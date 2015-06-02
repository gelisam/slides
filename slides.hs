{-# LANGUAGE BangPatterns #-}

import Data.Array


sumList :: [Double] -> Double
sumList = go 0
  where
    go :: Double -> [Double] -> Double
    go !acc []     = acc
    go !acc (x:xs) = go (acc + x) xs

sumArray :: Array Int Double -> Double
sumArray arr = go 0 i0
  where
    go :: Double -> Int -> Double
    go !acc i | i > n     = acc
              | otherwise = go (acc + arr ! i) (i+1)
    
    i0, n :: Int
    (i0, n) = bounds arr


sampleList :: [Double]
sampleList = [1.0,1.1..3.0]

sampleArray :: Array Int Double
sampleArray = listArray (1, length sampleList) sampleList

main :: IO ()
main = do
    print $ sumList sampleList
    print $ sumArray sampleArray








































































































