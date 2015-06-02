{-# LANGUAGE BangPatterns #-}

-- Arrays? In Haskell? Do you mean lists?


sumList :: [Double] -> Double
sumList = go 0
  where
    go :: Double -> [Double] -> Double
    go !acc []     = acc
    go !acc (x:xs) = go (acc + x) xs

sampleList :: [Double]
sampleList = [1.0,1.1..3.0]

main :: IO ()
main = print $ sumList sampleList








































































































