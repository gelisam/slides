module Slide where
import Test.DocTest                                                                                                    ; import Data.Foldable

-- |
-- >>> helloWorldPure
-- ["hello","world"]
helloWorldPure :: [String]
helloWorldPure = ["hello", "world"]

-- |
-- >>> manyNumbersPure
-- ["1","2","3","4","5"]
manyNumbersPure :: [String]
manyNumbersPure = flip fmap [1..5] $ \i -> do
                    show i



































































































main :: IO ()
main = doctest ["src/Slide.hs"]
