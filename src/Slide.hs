module Slide where
import Test.DocTest
import Control.Arrow
import Data.List

-- |
-- >>> quickSort [3,2,8,4,5,7,1,6]
-- [1,2,3,4,5,6,7,8]
quickSort :: forall a. Ord a
          => [a] -> [a]
quickSort = hylo divide conquer where
  divide :: [a] -> SearchTreeF a [a]
  divide []     = LeafF
  divide (a:as) = let (lower, higher) = partition (<= a) as
                  in BranchF lower a higher
  
  conquer :: SearchTreeF a [a] -> [a]
  conquer LeafF = []
  conquer (BranchF l a r) = l ++ [a] ++ r


hylo :: forall s f r. Functor f
     => (s -> f s) -> (f r -> r) -> s -> r
hylo divide conquer = go where
  go :: s -> r
  go = divide >>> fmap go >>> conquer















































































data SearchTreeF a r
  = LeafF
  | BranchF r a r
  deriving Functor

data SearchTree a
  = Leaf
  | Branch (SearchTree a) a (SearchTree a)


main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
