{-# LANGUAGE MultiWayIf #-}
import Data.Foldable

fizzbuzz :: IO ()
fizzbuzz = do
  for_ [1..100::Int] $ \i -> do
    if | i `mod` 15 == 0 -> putStrLn "fizzbuzz"
       | i `mod`  3 == 0 -> putStrLn "fizz"
       | i `mod`  5 == 0 -> putStrLn "buzz"
       | otherwise       -> print i



































































































main :: IO ()
main = fizzbuzz
