module Slide where
import Test.DocTest
import Control.Arrow
import Data.List

-- |
-- >>> quickSort [3,2,8,4,5,7,1,6]
-- [1,2,3,4,5,6,7,8]
quickSort :: forall a. Ord a
          => [a] -> [a]
quickSort []     = []
quickSort (a:as) = let (lower, higher) = partition (<= a) as
                   in quickSort lower ++ [a] ++ quickSort higher
























































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
