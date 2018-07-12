module Slide where
import Prelude hiding (sum, product, concat)
import Test.DocTest

-- |
-- >>> sum [1,2,3,4]
-- 10
-- >>> product [1,2,3,4]
-- 24
-- >>> concat ["foo","bar","baz"]
-- "foobarbaz"

sum :: [Int] -> Int
sum = fold (+) 0


product :: [Int] -> Int
product = fold (*) 1


concat :: [String] -> String
concat = fold (++) ""


fold :: (a -> a -> a) -> a -> [a] -> a
fold cons nil = go where
  go []     = nil
  go (a:as) = a `cons` go as



















































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
