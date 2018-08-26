module Slide where
import Test.DocTest

data Event = Color String | Click Int
data Segment = Segment String (Int,Int)
  deriving Show

-- |
-- >>> transform [Color "Red", Click 1, Click 2, Color "Blue", Click 3, Click 4]
-- [Segment "Red" (1,2),Segment "Blue" (3,4)]
transform :: [Event] -> [Segment]
transform = undefined























































































test :: IO ()
test = doctest ["src/Slide.hs"]

main :: IO ()
main = putStrLn "typechecks."
