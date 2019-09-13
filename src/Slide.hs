import Data.IORef

data FizzBuzzHandle = FizzBuzzHandle
  { fizz     :: IO ()
  , buzz     :: IO ()
  , fizzbuzz :: IO ()
  , number   :: Int -> IO ()
  , printAll :: IO ()
  }

newFizzBuzzHandle :: IO FizzBuzzHandle
newFizzBuzzHandle = do
  ref <- newIORef []
  pure $ FizzBuzzHandle
    { fizz     = modifyIORef ref (++ ["fizz"])
    , buzz     = modifyIORef ref (++ ["buzz"])
    , fizzbuzz = modifyIORef ref (++ ["buzzfizz"])
    , number   = \i -> modifyIORef ref (++ [show i])
    , printAll = do
        strings <- readIORef ref
        mapM_ putStrLn strings
    }

--

fizzbuzz1 :: FizzBuzzHandle -> Int -> IO ()
fizzbuzz1 h i | i `mod` 15 == 0 = fizzbuzz h
              | i `mod`  3 == 0 = fizz h
              | i `mod`  5 == 0 = buzz h
              | otherwise       = number h i

fizzbuzz100 :: FizzBuzzHandle -> IO ()
fizzbuzz100 h = do
  mapM_ (fizzbuzz1 h) [1..100]


main :: IO ()
main = do
  h <- newFizzBuzzHandle
  fizzbuzz100 h
  printAll h



































































































