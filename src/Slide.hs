module Slide where
import Control.Applicative
scanS            :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a
mapMaybeS        :: (a -> Maybe b) -> Signal (Maybe a) -> Signal (Maybe b)
neverS           :: Signal (Maybe a)
unionS           :: Signal (Maybe a) -> Signal (Maybe a) -> Signal (Maybe a)
lastS            :: a -> Signal (Maybe a) -> Signal a

events           :: Signal (Maybe Event)
clicks           :: Signal (Maybe Pos)
buttonClicks     :: Button -> Signal (Maybe Color)
colorPicks       :: Signal (Maybe Color)
currentColor     :: Signal Color


movingButtonClicks :: Signal Button -> Signal (Maybe Color)

movingToggleButton :: Signal Button
movingToggleButton = (\b -> if b then upperButton else lowerButton)
                 <$> toggled

toggled :: Signal Bool
toggled = scanS (\b _ -> not b) False (movingButtonClicks movingToggleButton)


























































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

upperButton = undefined
lowerButton = undefined
movingButtonClicks = undefined


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
