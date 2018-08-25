module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Codec.Picture hiding (Image); import Control.Applicative; import Control.Lens; import Data.Monoid; import Graphics.Gloss; import Graphics.Gloss.Interface.IO.Game; import Graphics.Gloss.Juicy; import System.Process


data DiscreteApp state = DiscreteApp
  { initialState :: state
  , handleEvent  :: state -> Event -> state
  , render       :: state -> Image
  }


type ContinuousApp = Animated (Maybe Event) -> Animated Image













































































type RGB = PixelRGBA8
type ContinuousImage = (Float,Float) -> RGB
type Image = ContinuousImage
type Animated a = Float -> a
type ContinuousAnimation = Animated Image


type Time = Float

type B a = ZipList a
type E a = ZipList (Maybe a)

time :: B Time
time = ZipList [0,1/fps..]

events :: Fold (E a) a
events = _Wrapped . each . _Just

fmapE :: (a -> b) -> E a -> E b
fmapE = fmap . fmap

setE :: b -> E a -> E b
setE = fmapE . const

memptyB :: Monoid a => B a
memptyB = pure mempty

mappendB :: Monoid a => B a -> B a -> B a
mappendB = liftA2 mappend

mconcatB :: Monoid a => [B a] -> B a
mconcatB = foldr mappendB memptyB

filterE :: (a -> Bool) -> E a -> E a
filterE p = fmap f
  where
    f (Just x) | p x = Just x
    f _        = Nothing

mapMaybeE :: (a -> Maybe b) -> E a -> E b
mapMaybeE f = fmap f'
  where
    f' (Just (f -> Just x)) = Just x
    f' _                    = Nothing

fromListE :: [a] -> E a
fromListE = ZipList . fmap Just

fromMaybeListE :: [Maybe a] -> E a
fromMaybeListE = ZipList

-- |
-- >>> take 3 $ getZipList $ neverE
-- [Nothing,Nothing,Nothing]
neverE :: E a
neverE = pure Nothing

-- |
-- >>> toListOf events $ neverE `unionE` fromListE [1,2,3]
-- [1,2,3]
-- >>> toListOf events $ fromMaybeListE [Just 1, Nothing, Just 2, Nothing] `unionE` fromMaybeListE [Nothing, Nothing, Just 3, Just 4]
-- [1,2,4]
unionE :: E a -> E a -> E a
unionE = liftA2 (<|>)

-- |
-- >>> getZipList $ scanB (+) 0 $ fromListE [1,20,300]
-- [0,1,21,321]
scanB :: (a -> b -> a) -> a -> E b -> B a
scanB f x0 = ZipList . scanl f' x0 . getZipList
  where
    f' x Nothing  = x
    f' x (Just y) = f x y

-- |
-- >>> toListOf events $ scanE (+) 0 $ fromListE [1,20,300]
-- [1,21,321]
scanE :: (a -> b -> a) -> a -> E b -> E a
scanE f x0 ys = f' <$> scanB f x0 ys <*> ys
  where
    f' x Nothing  = Nothing
    f' x (Just y) = Just (f x y)

foldE :: Monoid a => E a -> E a
foldE = scanE mappend mempty

foldMapE :: Monoid b => (a -> b) -> E a -> E b
foldMapE f = foldE . fmapE f

-- |
-- >>> getZipList $ lastB 0 $ fromMaybeListE [Just 1, Just 2, Nothing, Just 4]
-- [0,1,2,2,4]
lastB :: a -> E a -> B a
lastB = scanB (curry snd)

applyBE :: (a -> b -> c) -> B a -> E b -> E c
applyBE f xs ys = f' <$> xs <*> ys
  where
    f' x Nothing  = Nothing
    f' x (Just y) = Just (f x y)

-- |
-- >>> toListOf events $ historyE neverE $ fromListE [1,2,3,4,5]
-- [[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]
-- >>> toListOf events $ historyE (fromMaybeListE [Nothing, Nothing, Nothing, Just (), Nothing, Nothing]) (fromListE [1..6])
-- [[1],[1,2],[1,2,3],[1,2,3,4],[5],[5,6]]
historyE :: E () -> E a -> E [a]
historyE resets xs = go
  where
    snoc xs x = xs ++ [x]
    go = applyBE snoc soFar xs
    soFar = lastB [] (setE [] resets `unionE` go)

-- |
-- >>> toListOf events $ pairsE neverE $ fromListE [1..5]
-- [(1,2),(3,4)]
pairsE :: E () -> E a -> E (a,a)
pairsE resets xs = go
  where
    go = mapMaybeE f
       $ historyE (resets `unionE` setE () go) xs

    f :: [a] -> Maybe (a,a)
    f [x1,x2] = Just (x1,x2)
    f _       = Nothing


windowWidth, windowHeight :: Int
(windowWidth, windowHeight) = (640, 480)

fps :: Float
fps = 30

lineThickness :: Float
lineThickness = 20

mwhen :: Monoid a => Bool -> a -> a
mwhen True  x = x
mwhen False _ = mempty


data Pos = Pos
  { _posX :: Float
  , _posY :: Float
  }
  deriving Show
makeLenses ''Pos

clickEvents :: [(Time, Pos)]
clickEvents = 
  [ (1.0, Pos (-75) (-140))
  , (2.0, Pos    0   (-20))
  , (3.0, Pos (-50)  (-80))
  , (4.0, Pos   30  (-140))
  , (5.0, Pos (-50)    70 )
  , (6.0, Pos   50   (-80))
  ]

endOfSimulation :: Time
endOfSimulation = 7.5


clicks :: E Pos
clicks = ZipList $ go 0 clickEvents
  where
    dt = 1/fps
    go t []
      | t <= endOfSimulation = Nothing : go (t+dt) []
      | otherwise            = []
    go t allClicks@((clickTime,click):laterClicks)
      | clickTime <= t = Just click : go (t+dt) laterClicks
      | otherwise      = Nothing    : go (t+dt) allClicks

drawClick :: Float -> Time -> (Time, Pos) -> Picture
drawClick r0 t (timestamp, click) = mwhen (dt >= 0 && dt <= 1)
                                  $ color (withAlpha (1-dt) black)
                                  $ translate (click ^. posX)
                                              (click ^. posY)
                                  $ circle (50 * dt + r0)
  where
    dt = t - timestamp

drawClicks :: Float -> Time -> [(Time, Pos)] -> Picture
drawClicks r0 t = foldMap (drawClick r0 t)


timestampedClicks :: E (Time, Pos)
timestampedClicks = applyBE (,) time clicks

clickCircles :: Float -> B Picture
clickCircles r0 = drawClicks r0
              <$> time
              <*> lastB [] (historyE neverE timestampedClicks)


type Tween = Float -> Float

linear :: Tween
linear = id

speedUp :: Tween
speedUp t = t * t

slowDown :: Tween
slowDown t = 1 - speedUp (1 - t)

pieces :: [(Float, Float, Tween)] -> Tween
pieces = go 0
  where
    go x0 [] _ = 1
    go x0 ((t0,d0,tween0):tweens) t
      | t < t0    = x0 + tween0 (t / t0) * d0
      | otherwise = go (x0 + d0) tweens (t-t0)

reachAndPause :: Tween
reachAndPause = pieces
  [ (0.1, 0.0, linear)
  , (0.4, 0.5, speedUp)
  , (0.4, 0.5, slowDown)
  ]


mousePos :: B Pos
mousePos = ZipList $ go 0 0 0 0 clickEvents
  where
    interpolate frac x x' = x + reachAndPause frac * (x' - x)

    dt = 1/fps
    go t t0 x0 y0 allClicks@((t1,Pos x1 y1):laterClicks)
      | t1 <= t   = Pos x1 y1 : go (t+dt) t1 x1 y1 laterClicks
      | otherwise = Pos x  y  : go (t+dt) t0 x0 y0 allClicks
      where 
        frac = (t - t0) / (t1 - t0)
        x = interpolate frac x0 x1
        y = interpolate frac y0 y1
    go _ _ x0 y0 _ = repeat (Pos x0 y0)

mouseShape :: Path
mouseShape = [ (0 ,  0)
             , (12,-12)
             , ( 5,-12)
             , ( 9,-19)
             , ( 7,-20)
             , ( 4,-13)
             , ( 0,-17)
             ]

drawMouseCursor :: Pos -> Picture
drawMouseCursor pos = translate (pos ^. posX) (pos ^. posY)
                    $ polygon mouseShape

mouseCursors :: B Picture
mouseCursors = drawMouseCursor <$> mousePos


mouseStuff :: Float -> B Picture
mouseStuff r0 = clickCircles r0
     `mappendB` mouseCursors


data Rect = Rect
  { _rectCenter :: Pos
  , _rectWidth  :: Float
  , _rectHeight :: Float
  }
makeLenses ''Rect

isInside :: Pos -> Rect -> Bool
isInside pos rect = x >= left   && x <= right
                 && y >= bottom && y <= top
  where
    x = pos ^. posX
    y = pos ^. posY
    w = rect ^. rectWidth
    h = rect ^. rectHeight
    left   = rect ^. rectCenter . posX - w/2
    right  = rect ^. rectCenter . posX + w/2
    bottom = rect ^. rectCenter . posY - h/2
    top    = rect ^. rectCenter . posY + h/2


data Button = Button
  { _buttonColor :: Color
  , _buttonRect  :: Rect
  }
makeLenses ''Button

drawButton :: Button -> Picture
drawButton (Button c (Rect (Pos x y) w h))
  = translate x y
  $ (color c $ rectangleSolid w h)
 <> rectangleWire w h

drawColorButton :: Color -> Button -> Picture
drawColorButton c button = mwhen (c == button ^. buttonColor)
                                 (drawButton selection)
                        <> drawButton button
  where
    selector = Button white (Rect (Pos 0 0) 34 34)
    selection = selector
              & buttonRect . rectCenter .~ button ^. buttonRect . rectCenter

canvasButton :: Button
canvasButton = Button white (Rect (Pos 0 0) 320 240)

colorButtons :: [Button]
colorButtons = zipWith makeButton
                       [black, white, red, yellow, green, blue]
                       [0..]
  where
    makeButton :: Color -> Int -> Button
    makeButton c n = Button c (Rect (Pos x y) 30 30)
      where
        x = fromIntegral n * 35 - 145
        y = -140

buttonClicks :: Button -> E (Pos, Color)
buttonClicks button = fmapE (, button ^. buttonColor)
                    . filterE (`isInside` (button ^. buttonRect))
                    $ clicks

colorPicks :: E Color
colorPicks = fmapE snd
           . foldr unionE neverE
           . fmap buttonClicks
           $ colorButtons

currentColor :: B Color
currentColor = lastB black colorPicks


data SegmentEnd = SegmentEnd
  { _segmentEndPos   :: Pos
  , _segmentEndColor :: Color
  }
makeLenses ''SegmentEnd

drawSegmentEnd :: SegmentEnd -> Picture
drawSegmentEnd segmentEnd = color (segmentEnd ^. segmentEndColor)
                          $ translate (segmentEnd ^. segmentEndPos . posX)
                                      (segmentEnd ^. segmentEndPos . posY)
                          $ circleSolid (lineThickness / 2)

canvasClicks :: E (Pos, Color)
canvasClicks = applyBE (set _2) currentColor (buttonClicks canvasButton)

segmentEndAdditions :: E SegmentEnd
segmentEndAdditions = fmapE (uncurry SegmentEnd) canvasClicks

segmentEnds :: B Picture
segmentEnds = lastB mempty
            . foldMapE drawSegmentEnd
            $ segmentEndAdditions


data Segment = Segment
  { _segmentStart :: Pos
  , _segmentStop  :: Pos
  , _segmentColor :: Color
  }
makeLenses ''Segment

drawSegment :: Segment -> Picture
drawSegment segment = color (segment ^. segmentColor)
                    $ translate x1 y1
                    $ rotate (-degrees)
                    $ translate (dist / 2) 0
                    $ rectangleSolid dist lineThickness
  where
    (x1,y1) = (segment ^. segmentStart . posX, segment ^. segmentStart . posY)
    (x2,y2) = (segment ^. segmentStop  . posX, segment ^. segmentStop  . posY)
    (dx,dy) = (x2 - x1, y2 - y1)
    dist = sqrt (dx*dx + dy*dy)
    radians = atan2 dy dx
    degrees = radians * 180 / pi

segmentAdditions :: E Segment
segmentAdditions = fmapE (uncurry f)
                 $ pairsE (setE () colorPicks) canvasClicks
  where
    f (start, c) (stop, _) = Segment start stop c

segments :: B Picture
segments = lastB mempty
         . foldMapE drawSegment
         $ segmentAdditions


data World = World
  { _worldPictures :: B Picture
  }
  deriving Show
makeLenses ''World

initialWorld :: World
initialWorld = World (ZipList [])


paused :: Picture
paused = color (greyN 0.5) (rectangleSolid (fromIntegral windowWidth)
                                           (fromIntegral windowHeight))
      <> color (greyN 0.7) (circleSolid 50)
      <> color black (polygon [(-15,20),(25,0),(-15,-20)])

widgets :: B Picture
widgets = mconcatB
        $ pure (drawButton canvasButton)
        : fmap (\colorButton -> drawColorButton
                            <$> currentColor
                            <*> pure colorButton)
               colorButtons

input :: B Picture
input = mouseStuff 0 

output :: B Picture
output = mconcatB
  [ widgets
  , segmentEnds
  , segments
  ]

inputAndOutput :: B Picture
inputAndOutput = liftA2 (<>) output (mouseStuff (lineThickness / 2))

draw :: World -> Picture
draw world = case world ^? worldPictures . _Wrapped . each of
  Just picture -> picture
  Nothing      -> paused

onEvent :: Event -> World -> World
onEvent (EventKey (Char key) keyState _ _) = onKey key keyState
onEvent _ = id

onKey :: Char -> KeyState -> World -> World
onKey '1' Down = (worldPictures .~ input)
onKey '2' Down = (worldPictures .~ output)
onKey '3' Down = (worldPictures .~ inputAndOutput)
onKey _ _ = id

onTimeDelta :: Float -> World -> World
onTimeDelta _ = worldPictures . _Wrapped %~ drop 1

test :: IO ()
test = do
  --doctest ["-XTemplateHaskell", "-XTupleSections", "-XViewPatterns", "src/Slide.hs"]
  _ <- system "stack build && write-your-own-frp"
  putStrLn "done."

main :: IO ()
main = play (InWindow "gloss" (windowWidth, windowHeight) (800, 0))
            white
            (round fps)
            initialWorld
            draw
            onEvent
            onTimeDelta
