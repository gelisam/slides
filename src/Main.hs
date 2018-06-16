import Control.DeepSeq
import Data.List
import Test.DocTest

-- |
-- >>> :set +s
-- >>> rnf computation
computation :: [Int]
computation = myconcat [[x] | x <- [0..10000]]

myconcat :: [[a]] -> [a]
myconcat = foldr (++) []

-- [0] ++ ([1] ++ ([2] ++ ([3] ++ ([4] ++ []))))
-- [0] ++ ([1] ++ [2,3,4])

append :: [a] -> [a] -> [a]
append []     ys = ys
append (x:xs) ys = x : append xs ys




























































main :: IO ()
main = doctest ["src/Main.hs"]
