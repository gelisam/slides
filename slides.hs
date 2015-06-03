-- Ix
{-# LANGUAGE FlexibleInstances #-}

class Ord a => Ix a where
    index     :: (a,a) -> a -> Int
    rangeSize :: (a,a) -> Int

instance Ix Int where
    index (i0, n) i = i - i0
    rangeSize (i0, n) = n - i0 + 1

instance Ix (Int, Int) where
    index ((i0,j0), (n,m)) (i,j) = (j - j0) * w
                                 + (i - i0)
      where
        w = rangeSize (i0, n)
    rangeSize ((i0,j0), (n,m)) = rangeSize (i0, n)
                               * rangeSize (j0, m)


bounds :: ((Int,Int), (Int, Int))
bounds = ((0,0), (9,9))

-- |
-- >>> main
-- 52
main :: IO ()
main = print $ index bounds (2,5)




























































































