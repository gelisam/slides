module Slide where
import Prelude
import Test.DocTest


foldList :: (ListF a r -> r) -> List a -> r
foldList = fold



foldTree :: (TreeF a r -> r) -> Tree a -> r
foldTree = fold



fold     :: (tF      r -> r) -> t      -> r
















































































data ListF a r
  = NilF
  | ConsF a r

data List a
  = Nil
  | Cons a (List a)


data TreeF a r
  = LeafF a
  | BranchF r r

data Tree a
  = Leaf a
  | Branch (Tree a) (Tree a)


fold = undefined


main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
