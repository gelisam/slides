-- Ix
{-# LANGUAGE FlexibleInstances #-}

class Ord a => Ix a where
    index :: a -> Int

instance Ix Int where
    index i = i

instance Ix (Int, Int) where
    index (i,j) = j * w + i
      where
        w = ?




























































































