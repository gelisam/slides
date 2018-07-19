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
showTree = foldTree branch leaf where
  leaf a     = ["Leaf " ++ show a]
  branch l r = ["Branch"]
            ++ map ("  " ++) l
            ++ map ("  " ++) r

-- |
-- >>> concatTree myTree
-- "foobarbaz"
concatTree :: Tree String -> String
concatTree = foldTree (++) id

-- |
-- >>> depth myTree
-- 3
depth :: Tree a -> Int
depth = foldTree cons (const 1) where
  cons l r = 1 + max r l

-- |
-- >>> mapM_ putStrLn $ showTree $ fmap (++"!") myTree
-- Branch
--   Leaf "foo!"
--   Branch
--     Leaf "bar!"
--     Leaf "baz!"
fmap :: forall a b. (a -> b) -> Tree a -> Tree b
fmap f = foldTree Branch (Leaf . f)





foldTree :: (r -> r -> r) -> (a -> r) -> Tree a -> r
foldTree branch leaf = go where
  go (Leaf a)             = leaf a
  go (Branch treeL treeR) = branch (go treeL) (go treeR)




















































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
