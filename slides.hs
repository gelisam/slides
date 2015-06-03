-- laziness-based caching

import Debug.Trace
import Text.Printf

noisyAdd :: Integer -> Integer -> Integer
noisyAdd x y = trace (printf "adding %d %d" x y)
                     (x + y)


fib :: Int -> Integer
fib n = fibs !! n
  where
    fibs :: [Integer]
    fibs = 1:1:zipWith noisyAdd fibs (tail fibs)


main :: IO ()
main = do
    print $ fib 9
    print $ fib 10


























































































