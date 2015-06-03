-- laziness-based caching
{-# LANGUAGE ScopedTypeVariables #-}
import Debug.Trace
import Text.Printf

noisyAdd :: Num a => a -> a -> a
noisyAdd x y = trace "adding things"
                     (x + y)


fib :: forall a. Num a => Int -> a
fib = (fibs !!)
  where
    fibs :: [a]
    fibs = 1:1:zipWith noisyAdd fibs (tail fibs)


main :: IO ()
main = do
    print $ fib 9
    print $ fib 10


























































































