-- Ix
{-# LANGUAGE FlexibleInstances #-}

class Ord a => Ix a where
    index :: a -> a -> Int

instance Ix Int where
    index n i = i

instance Ix (Int, Int) where
    index (w,h) (i,j) = j * w + i


bounds :: (Int, Int)
bounds = (10,10)

-- |
-- >>> main
-- 52
main :: IO ()
main = print $ index bounds (2,5)




























































































