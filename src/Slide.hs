module Slide where
import Control.Applicative
scanS            :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a
mapMaybeS        :: (a -> Maybe b) -> Signal (Maybe a) -> Signal (Maybe b)
neverS           :: Signal (Maybe a)
unionS           :: Signal (Maybe a) -> Signal (Maybe a) -> Signal (Maybe a)
lastS            :: a -> Signal (Maybe a) -> Signal a
pairS            :: Signal (Maybe a) -> Signal (Maybe (a,a))

events           :: Signal (Maybe Event)
clicks           :: Signal (Maybe Pos)
buttonClicks     :: Button -> Signal (Maybe Color)
colorPicks       :: Signal (Maybe Color)
currentColor     :: Signal Color
canvasClicks     :: Signal (Maybe Pos)
segmentAdditions :: Signal (Maybe Segment)




























































data RGB
data Array i a
data Event

data Color

black :: Color
black = undefined

type ContinuousImage = (Float,Float) -> RGB
type Image = ContinuousImage

textC :: String -> ContinuousImage
textC = undefined

type Animated a = Float -> a
type ContinuousAnimation = Animated ContinuousImage

data Signal a
type ContinuousApp = Signal (Maybe Event) -> Signal ContinuousImage

instance Functor Signal where
  fmap = undefined

instance Applicative Signal where
  pure  = undefined
  (<*>) = undefined

events = undefined

scanS = undefined

mapMaybeS f = fmap (>>= f)

data Pos
data Rect

data Button = Button
  { buttonColor :: Color
  , buttonRect  :: Rect
  }

data Segment = Segment
  { segmentColor  :: Color
  , segmentPoints :: (Pos, Pos)
  }

colorButtons :: [Button]
colorButtons = undefined

matchClick :: Event -> Maybe Pos
matchClick = undefined

clicks = mapMaybeS matchClick events

isInside   :: Pos -> Rect -> Bool
isInside   = undefined

drawButton :: Button -> Image
drawButton = undefined

buttonClicks (Button {..}) = mapMaybeS f clicks
  where
    f :: Pos -> Maybe Color
    f pos = if pos `isInside` buttonRect
            then Just buttonColor
            else Nothing

neverS = pure Nothing

unionS = liftA2 (<|>)

colorPicks = foldr unionS neverS (fmap buttonClicks colorButtons)

lastS = scanS (curry snd)

currentColor = lastS black colorPicks

segmentAdditions = liftA2 Segment <$> (Just <$> currentColor)
                                  <*> pairS canvasClicks

pairS inputs = liftA2 (,) <$> prevs <*> inputs
  where
    toggle Nothing  x = Just x
    toggle (Just _) _ = Nothing

    prevs = scanS toggle Nothing inputs

canvasClicks = undefined


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
