module Slide where
import Control.Arrow
import Test.DocTest

data SearchTree a
  = Leaf
  | Branch (SearchTree a) a (SearchTree a)

--              2             2    
--             / \           / \
--            /   \         /   \
-- insert 1  0     4   ->  0     4  
--                / \       \   / \
--               3   5       1 3   5
insert :: Ord a
       => a -> SearchTree a -> SearchTree a
insert new Leaf = Branch Leaf new Leaf
insert new (Branch l a r)
  | new <= a  = Branch (insert new l) a r
             -- Branch (insert new l) a (insert new r)
  | otherwise = Branch l a (insert new r)




















































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
