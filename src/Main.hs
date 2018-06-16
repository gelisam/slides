instance Semigroup (DList a) where
  DList f <> DList g = DList (f . g)

makeDList :: [a] -> DList a
makeDList xs = DList (xs ++)

-- DList (("foo" ++) . ("bar" ++) . ("baz" ++))
-- DList (\nil -> ("foo" ++) . ("bar" ++) . ("baz" ++) $ nil)
-- DList (\nil -> ("foo" ++) (("bar" ++) (("baz" ++) nil)))
-- DList (\nil -> "foo" ++ ("bar" ++ ("baz" ++ nil)))


instance Semigroup (SList a) where
  SList f <> SList g = SList (g . f)

makeSList :: [a] -> SList a
makeSList xs = SList (++ xs)

-- SList ((++ "baz") . (++ "bar") . (++ "foo"))
-- SList (\nil -> (++ "baz") . (++ "bar") . (++ "foo") $ nil)
-- SList (\nil -> (++ "baz") ((++ "bar") ((++ "foo") nil)))
-- SList (\nil -> ((nil ++ "foo") ++ "bar") ++ "baz")

























































newtype DList a = DList { unDList :: [a] -> [a] }
newtype SList a = SList { unSList :: [a] -> [a] }

main :: IO ()
main = putStrLn "done."
