{-# LANGUAGE GeneralizedNewtypeDeriving #-}
import Control.Monad.Writer

newtype FizzBuzz a = UnsafeFizzBuzz
  { unFizzBuzz :: Writer [String] a }
  deriving (Functor, Applicative, Monad)

runFizzBuzz :: FizzBuzz a -> IO a
runFizzBuzz body = do
  let (a, strings) = runWriter (unFizzBuzz body)
  mapM_ putStrLn strings
  pure a

fizz :: FizzBuzz ()
fizz = UnsafeFizzBuzz $ tell ["fizz"]

buzz :: FizzBuzz ()
buzz = UnsafeFizzBuzz $ tell ["buzz"]

fizzbuzz :: FizzBuzz ()
fizzbuzz = UnsafeFizzBuzz $ tell ["fizzbuzz"]

number :: Int -> FizzBuzz ()
number i = UnsafeFizzBuzz $ tell [show i]

--

fizzbuzz1 :: Int -> FizzBuzz ()
fizzbuzz1 i | i `mod` 15 == 0 = fizzbuzz
            | i `mod`  3 == 0 = fizz
            | i `mod`  5 == 0 = buzz
            | otherwise       = number i

fizzbuzz100 :: FizzBuzz ()
fizzbuzz100 = do
  mapM_ fizzbuzz1 [1..100]


main :: IO ()
main = runFizzBuzz fizzbuzz100



































































































