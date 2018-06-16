import Test.DocTest

newtype DList a = DList
  { unDList :: [a] -> [a] }

-- |
-- >>> fromDList mempty :: String
-- ""
instance Monoid (DList a) where
  mempty = DList id

-- |
-- >>> fromDList (makeDList "foo" <> makeDList "bar")
-- "foobar"
instance Semigroup (DList a) where
  DList f <> DList g = DList (f . g)


























































makeDList :: [a] -> DList a
makeDList xs = DList (xs ++)

fromDList :: DList a -> [a]
fromDList xs = unDList xs []


main :: IO ()
main = doctest ["src/Main.hs"]
