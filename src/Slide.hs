module Slide where

scanS            :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a
mapMaybeS        :: (a -> Maybe b) -> Signal (Maybe a) -> Signal (Maybe b)

events           :: Signal (Maybe Event)
clicks           :: Signal (Maybe Pos)


data Button = Button { buttonColor :: Color
                     , buttonRect  :: Rect }

isInside   :: Pos -> Rect -> Bool
drawButton :: Button -> Image

buttonClicks :: Button -> Signal (Maybe Color)
buttonClicks (Button {..}) = mapMaybeS f clicks
  where
    f :: Pos -> Maybe Color
    f pos = if pos `isInside` buttonRect
            then Just buttonColor
            else Nothing

































































data RGB
data Array i a
data Color
data Event

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

matchClick :: Event -> Maybe Pos
matchClick = undefined

clicks = mapMaybeS matchClick events

isInside   = undefined
drawButton = undefined


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
