module Slide where
import Prelude
import Test.DocTest


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
foldList :: (ListF a r -> r) -> List a -> r
foldList foldF = go where
  go Nil         = foldF $ NilF
  go (Cons a as) = foldF $ ConsF a (go as)


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
foldTree :: (TreeF a r -> r) -> Tree a -> r
foldTree foldF = go where
  go (Leaf a)             = foldF $ LeafF a
  go (Branch treeL treeR) = foldF $ BranchF (go treeL) (go treeR)




















































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
