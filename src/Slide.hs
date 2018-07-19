module Slide where
import Prelude hiding (fmap)
import Test.DocTest


data Tree a
  = Leaf a
  | Branch (Tree a) (Tree a)

--      *
--     / \
--    /   *
-- "foo" / \
--      /   \
--   "bar" "baz"
myTree :: Tree String
myTree = Branch
           (Leaf "foo")
           (Branch (Leaf "bar") (Leaf "baz"))


-- |
-- >>> mapM_ putStrLn $ showTree myTree
-- Branch
--   Leaf "foo"
--   Branch
--     Leaf "bar"
--     Leaf "baz"
showTree :: Show a => Tree a -> [String]
showTree (Leaf a)             = ["Leaf " ++ show a]
showTree (Branch treeL treeR) = ["Branch"]
                             ++ map ("  " ++) (showTree treeL)
                             ++ map ("  " ++) (showTree treeR)

-- |
-- >>> concatTree myTree
-- "foobarbaz"
concatTree :: Tree String -> String
concatTree (Leaf s)             = s
concatTree (Branch treeL treeR) = concatTree treeL ++ concatTree treeR

-- |
-- >>> depth myTree
-- 3
depth :: Tree a -> Int
depth (Leaf _)             = 1
depth (Branch treeL treeR) = 1 + max (depth treeL) (depth treeR)

-- |
-- >>> mapM_ putStrLn $ showTree $ fmap (++"!") myTree
-- Branch
--   Leaf "foo!"
--   Branch
--     Leaf "bar!"
--     Leaf "baz!"
fmap :: forall a b. (a -> b) -> Tree a -> Tree b
fmap f = go where
  go :: Tree a -> Tree b
  go (Leaf a)             = Leaf (f a)
  go (Branch treeL treeR) = Branch (go treeL) (go treeR)


foldTree :: (r -> r -> r) -> (a -> r) -> Tree a -> r
foldTree branch leaf = go where
  go (Leaf a)             = leaf a
  go (Branch treeL treeR) = branch (go treeL) (go treeR)




















































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
