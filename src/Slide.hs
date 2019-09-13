
class Monad m => MonadFizzBuzz m where
  fizz     :: m ()
  buzz     :: m ()
  fizzbuzz :: m ()
  number   :: Int -> m()

fizzbuzz1 :: MonadFizzBuzz m
          => Int -> m ()
fizzbuzz1 i | i `mod` 15 == 0 = fizzbuzz
            | i `mod`  3 == 0 = fizz
            | i `mod`  5 == 0 = buzz
            | otherwise       = number i

fizzbuzz100 :: MonadFizzBuzz m
            => m ()
fizzbuzz100 = do
  mapM_ fizzbuzz1 [1..100]


instance MonadFizzBuzz IO where
  fizz     = putStrLn "fizz"
  buzz     = putStrLn "buzz"
  fizzbuzz = putStrLn "fizzbuzz"
  number i = print i

main :: IO ()
main = fizzbuzz100



































































































