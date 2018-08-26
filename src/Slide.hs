module Slide where
import Control.Applicative
scanS            :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a
mapMaybeS        :: (a -> Maybe b) -> Signal (Maybe a) -> Signal (Maybe b)

events           :: Signal (Maybe Event)
clicks           :: Signal (Maybe Pos)
buttonClicks     :: Button -> Signal (Maybe Color)


neverS :: Signal (Maybe a)
neverS = pure Nothing

unionS :: Signal (Maybe a) -> Signal (Maybe a) -> Signal (Maybe a)
unionS = liftA2 (<|>)

colorButtons :: [Button]

colorPicks :: Signal (Maybe Color)
colorPicks = foldr unionS neverS (fmap buttonClicks colorButtons)
































































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

data Button = Button
  { buttonColor :: Color
  , buttonRect  :: Rect
  }

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


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
