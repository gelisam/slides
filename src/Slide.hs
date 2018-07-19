module Slide where
import Test.DocTest
import Control.Arrow
import Data.List

fold :: forall t tF r. Functor tF
     => (t -> tF t) -> (tF r -> r) -> t -> r
fold project foldF = hylo project foldF













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
