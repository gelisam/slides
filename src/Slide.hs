module Slide where
import Test.DocTest
import Control.Arrow

type Input  a = SearchTree a
type Output a = SearchTree a

--        2     
--       / \    
--      /   \   
-- go  0     4  
--          / \ 
--         3   5
--     v
--   project
--     v
-- BranchF  0   2   4
--                 / \
--                3   5
--     v
--   fmap go
--     v
-- BranchF ( 0 , 0 )  2 (  4  ,  4  )
--                \       / \   / \
--                 1     3   5 3   5
--                            /
--                           1
--     v
--   (insertF &&& id)
--     v
--        2        BranchF ( 0 , 0 )  2  (  4  ,  4  )
--       / \                      \        / \   / \
-- (    /   \    ,                 1      3   5 3   5   )
--     0     4                                 /
--      \   / \                               1
--       1 3   5
--     v
--   uncurry gather
--     v
--      2           2    
--     / \         / \
--    /   \       /   \
-- ( 0     4  ,  0     4  )
--        / \     \   / \
--       3   5     1 3   5
insert :: forall a. Ord a
       => a -> Input a -> Output a
insert new = gcata project gather insertF where
  project :: Input a -> SearchTreeF a (Input a)
  project Leaf           = LeafF
  project (Branch l a r) = BranchF l a r

  gather :: Output a
         -> SearchTreeF a (Input a, Output a)
         -> (Input a, Output a)
  gather o LeafF                       = (Leaf, o)
  gather o (BranchF (iL,oL) a (iR,oR)) = (Branch iL a iR, Branch oL a oR)

  insertF :: SearchTreeF a (Input a, Output a) -> Output a
  insertF LeafF = Branch Leaf new Leaf
  insertF (BranchF (iL,oL) a (iR,oR))
    | new <= a  = Branch oL a iR
    | otherwise = Branch iL a oR


















































































data SearchTree a
  = Leaf
  | Branch (SearchTree a) a (SearchTree a)

data SearchTreeF a r
  = LeafF
  | BranchF r a r
  deriving Functor


gcata :: forall s f z r. Functor f
      => (s -> f s)
      -> (r -> f z -> z)
      -> (f z -> r)
      -> s -> r
gcata project gather gcataF = gcataF . fmap go . project where
  go :: s -> z
  go = project >>> fmap go >>> (gcataF &&& id) >>> uncurry gather


main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
