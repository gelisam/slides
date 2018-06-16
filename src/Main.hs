import Control.DeepSeq
import Data.List
import Test.DocTest

-- |
-- >>> :set +s
-- >>> rnf computation
computation :: Int
computation = sum [1..10^6]





























































main :: IO ()
main = doctest ["src/Main.hs"]
