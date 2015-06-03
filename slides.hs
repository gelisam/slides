-- laziness-based caching

import Debug.Trace
import Text.Printf

noisyAdd :: Integer -> Integer -> Integer
noisyAdd x y = trace (printf "adding %d %d" x y)
                     (x + y)


fibs :: [Integer]
fibs = 1:1:zipWith noisyAdd fibs (tail fibs)

fib :: Int -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) `noisyAdd` fib (n-2)


main :: IO ()
main = print $ fib 10


























































































