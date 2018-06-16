import Control.DeepSeq
import Data.List
import Data.Sequence (Seq)
import Test.DocTest
import qualified Data.Sequence as Seq

-- |
-- >>> :set +s
-- >>> rnf computation
computation :: Seq Int
computation = myconcat [Seq.singleton x | x <- [0..10000]]

myconcat :: [Seq a] -> Seq a
myconcat = foldl' (<>) Seq.empty





























































main :: IO ()
main = doctest ["src/Main.hs"]
