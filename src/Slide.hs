module Slide where
import Prelude
import Test.DocTest


foldList :: (ListF a r -> r) -> List a -> r




foldTree :: (TreeF a r -> r) -> Tree a -> r



















































































data ListF a r
  = NilF
  | ConsF a r

data List a
  = Nil
  | Cons a (List a)

-- Cons 1 (Cons 2 (Cons 3 Nil))
--              v
--              v
-- cons 1 (cons 2 (cons 3 nil))
foldList foldF = go where
  go Nil         = nil
  go (Cons a as) = cons a (go as)

  nil      = foldF NilF
  cons a r = foldF (ConsF a r)


data TreeF a r
  = LeafF a
  | BranchF r r

data Tree a
  = Leaf a
  | Branch (Tree a) (Tree a)

-- Branch (Leaf 1) (Branch (Leaf 2) (Leaf 3))
--                     v
--                     v
-- branch (leaf 1) (branch (leaf 2) (leaf 3))
foldTree foldF = go where
  go (Leaf a)             = leaf a
  go (Branch treeL treeR) = branch (go treeL) (go treeR)

  leaf a       = foldF (LeafF a)
  branch rL rR = foldF (BranchF rL rR)


main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
