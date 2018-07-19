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
sum []     = 0
sum (x:xs) = x + sum xs

product :: [Int] -> Int
product []     = 1
product (x:xs) = x * product xs

concat :: [String] -> String
concat []     = ""
concat (x:xs) = x ++ concat xs

























































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
