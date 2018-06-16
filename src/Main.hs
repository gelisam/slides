import Control.DeepSeq
import Data.List
import Test.DocTest

-- |
-- >>> :set +s
-- >>> rnf computation
computation :: [Int]
computation = myconcat [[x] | x <- [0..10000]]

myconcat :: [[a]] -> [a]
myconcat = fromDList
         . foldl' (<>) mempty
         . fmap makeDList


























































newtype DList a = DList { unDList :: [a] -> [a] }

instance Monoid (DList a) where
  mempty = DList id

instance Semigroup (DList a) where
  DList f <> DList g = DList (f . g)

makeDList :: [a] -> DList a
makeDList xs = DList (xs ++)

fromDList :: DList a -> [a]
fromDList xs = unDList xs []


main :: IO ()
main = doctest ["src/Main.hs"]
