

data FizzBuzzHandle = FizzBuzzHandle
  { fizz     :: IO ()
  , buzz     :: IO ()
  , fizzbuzz :: IO ()
  , number   :: Int -> IO ()
  }



newFizzBuzzHandle :: IO FizzBuzzHandle
newFizzBuzzHandle = do
  pure $ FizzBuzzHandle
    { fizz     = putStrLn "fizz"
    , buzz     = putStrLn "buzz"
    , fizzbuzz = putStrLn "buzzfizz"
    , number   = print
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




































































































