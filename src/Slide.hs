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
insert new = fold projectSearchTree $ \case
  LeafF -> Branch Leaf new Leaf
  BranchF (treeL, insertL) a (treeR, insertR)
    | new <= a  -> Branch insertL a treeR
    | otherwise -> Branch treeL a insertR


fold :: forall t tF r. Functor tF
     => (t -> tF t) -> (tF (t, r) -> r) -> t -> r
fold project foldF = go where
  go :: t -> r
  go = project >>> fmap (id &&& go) >>> foldF




data SearchTreeF a r
  = LeafF
  | BranchF r a r
  deriving Functor

projectSearchTree :: SearchTree a -> SearchTreeF a (SearchTree a)
projectSearchTree Leaf           = LeafF
projectSearchTree (Branch l a r) = BranchF l a r












































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
