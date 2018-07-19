module Slide where
import Prelude
import Test.DocTest


foldList :: (ListF a r -> r) -> List a -> r
foldList = fold $ \case
  Nil       -> NilF
  Cons a as -> ConsF a as

foldTree :: (TreeF a r -> r) -> Tree a -> r
foldTree = fold $ \case
  Leaf a     -> LeafF a
  Branch l r -> BranchF l r

fold     :: Functor tF
         => (t -> tF t)
         -> (tF      r -> r) -> t      -> r
















































































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


fold = undefined


main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
