-- Ix
{-# LANGUAGE FlexibleInstances #-}

class Ord a => Ix a where
    index     :: (a,a) -> a -> Int
    rangeSize :: (a,a) -> Int

data Pair a = Pair a a
  deriving (Eq, Ord, Ix)


bounds :: (Pair Int, Pair Int)
bounds = (Pair 0 0, Pair 9 9)

-- |
-- >>> main
-- 52
main :: IO ()
main = print $ index bounds (Pair 2 5)




























































































