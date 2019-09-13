import Control.Applicative
import Control.Monad


type FizzBuzz = Int -> Maybe String

runFizzBuzz :: FizzBuzz -> Int -> String
runFizzBuzz f n = case f n of
  Just s  -> s
  Nothing -> show n

ifMultipleOf :: String -> Int -> FizzBuzz
ifMultipleOf word n i = do
  guard (i `mod` n == 0)
  pure word

firstOf :: [FizzBuzz] -> FizzBuzz
firstOf []     _ = Nothing
firstOf (f:fs) i = f i <|> firstOf fs i

lastOf :: [FizzBuzz] -> FizzBuzz
lastOf = firstOf . reverse

allOf :: [FizzBuzz] -> FizzBuzz
allOf []     _ = pure ""
allOf (f:fs) i = (++) <$> f i <*> allOf fs i

--

fizz, buzz, fizzbuzz, fizzbuzz1 :: FizzBuzz
fizz = "fizz" `ifMultipleOf` 3
buzz = "buzz" `ifMultipleOf` 5
fizzbuzz = allOf [fizz, buzz]
fizzbuzz1 = firstOf [fizzbuzz, fizz, buzz]

fizzbuzz100 :: IO ()
fizzbuzz100 = do
  let strings = fmap (runFizzBuzz fizzbuzz1) [1..100]
  mapM_ putStrLn strings


































































































main :: IO ()
main = fizzbuzz100
