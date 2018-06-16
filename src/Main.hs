import Control.DeepSeq
import Data.List
import Test.DocTest


-- >>> :set +s
-- >>> rnf computation
computation :: [Int]
computation = myconcat [[x] | x <- [0..10000]]

myconcat :: [[a]] -> [a]
myconcat = foldr (++) []






























































main :: IO ()
main = putStrLn "done."
