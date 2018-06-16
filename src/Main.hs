import Test.DocTest

newtype DList a = DList
  { unDList :: [a] -> [a] }

-- (++)    :: [a] -> [a] -> [a]
-- (xs ++) ::        [a] -> [a]

makeDList :: [a] -> DList a
makeDList xs = DList (xs ++)

fromDList :: DList a -> [a]
fromDList xs = unDList xs []

-- |
-- >>> unDList foo ""
-- "foo"
-- >>> unDList foo "bar"
-- "foobar"
foo :: DList Char
foo = makeDList "foo"

























































main :: IO ()
main = doctest ["src/Main.hs"]
