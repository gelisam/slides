module Slide where
import Prelude
import Test.DocTest






data List a
  = Nil
  | Cons a (List a)

-- Cons 1 (Cons 2 (Cons 3 Nil))
--              v
--              v
-- cons 1 (cons 2 (cons 3 nil))
foldList :: ((a, r) -> r) -> (() -> r) -> List a -> r
foldList cons nil = go where
  go Nil         = nil ()
  go (Cons a as) = cons (a, go as)






data Tree a
  = Leaf a
  | Branch (Tree a) (Tree a)

-- Branch (Leaf 1) (Branch (Leaf 2) (Leaf 3))
--                     v
--                     v
-- branch (leaf 1) (branch (leaf 2) (leaf 3))
foldTree :: ((r, r) -> r) -> (a -> r) -> Tree a -> r
foldTree branch leaf = go where
  go (Leaf a)             = leaf a
  go (Branch treeL treeR) = branch (go treeL, go treeR)




















































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
