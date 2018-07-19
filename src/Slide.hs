module Slide where
import Prelude hiding (sum)
import Control.Arrow
import Test.DocTest

-- Cons 1 (Cons 2 (Cons 3 Nil))
--     v
--   projectList
--     v
-- ConsF 1 (Cons 2 (Cons 3 Nil))
--     v
--   fmap go
--     v
-- ConsF 1 5
--     v
--   sumF
--     v
-- 6
sum :: forall a. Num a
    => List a -> a
sum = go where
  go :: List a -> a
  go = projectList >>> fmap go >>> sumF

  projectList :: List a -> ListF a (List a)
  projectList Nil         = NilF
  projectList (Cons a as) = ConsF a as

  sumF :: ListF a a -> a
  sumF NilF              = 0
  sumF (ConsF a sumRest) = a + sumRest















































































data ListF a r
  = NilF
  | ConsF a r
  deriving Functor

data List a
  = Nil
  | Cons a (List a)


data TreeF a r
  = LeafF a
  | BranchF r r
  deriving Functor

data Tree a
  = Leaf a
  | Branch (Tree a) (Tree a)




main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
