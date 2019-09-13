
fizzbuzz1 :: Int -> String
fizzbuzz1 i | i `mod` 15 == 0 = "fizzbuzz"
            | i `mod`  3 == 0 = "fizz"
            | i `mod`  5 == 0 = "buzz"
            | otherwise       = show i

fizzbuzz100 :: IO ()
fizzbuzz100 = do
  let strings = fmap fizzbuzz1 [1..100]
  mapM_ putStrLn strings



































































































main :: IO ()
main = fizzbuzz100
