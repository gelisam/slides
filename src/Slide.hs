module Slide where

scanS            :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a

events           :: Signal (Maybe Event)


mapMaybeS :: (a -> Maybe b) -> Signal (Maybe a) -> Signal (Maybe b)
mapMaybeS f = fmap (>>= f)

matchClick :: Event -> Maybe Pos

clicks :: Signal (Maybe Pos)
clicks = mapMaybeS matchClick events


































































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

data Pos

matchClick = undefined


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
