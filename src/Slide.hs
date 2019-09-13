import Control.Monad
import Control.Monad.Free

data FizzBuzz r
  = Fizz       r
  | Buzz       r
  | Fizzbuzz   r
  | Number Int r

fizz :: Free FizzBuzz ()
fizz = liftF $ Fizz ()

buzz :: Free FizzBuzz ()
buzz = liftF $ Buzz ()

fizzbuzz :: Free FizzBuzz ()
fizzbuzz = liftF $ Fizzbuzz ()

number :: Int -> Free FizzBuzz ()
number i = liftF $ Number i ()

--

oneToOneHundred :: Free FizzBuzz ()
oneToOneHundred = do
  mapM_ number [1..100]

-- do number  1
--    number  2
--    number  3
--    number  4
--    number  5
--    number  6
--    number  7
--    number  8
--    number  9
--    number 10
--    number 11
--    number 12
--    number 13
--    number 14
--    number 15

addFizzesAndBuzzes :: Free FizzBuzz a -> Free FizzBuzz a
addFizzesAndBuzzes (Free (Number n cc)) = do
  when (n `mod` 3 == 0) $ do
    fizz
  when (n `mod` 5 == 0) $ do
    buzz
  number n
  addFizzesAndBuzzes cc
addFizzesAndBuzzes (Free fcc) = Free (fmap addFizzesAndBuzzes fcc)
addFizzesAndBuzzes (Pure a) = do
  pure a

-- do number  1
--    number  2
--    fizz
--    number  3
--    number  4
--    buzz
--    number  5
--    fizz
--    number  6
--    number  7
--    number  8
--    fizz
--    number  9
--    buzz
--    number 10
--    number 11
--    fizz
--    number 12
--    number 13
--    number 14
--    fizz
--    buzz
--    number 15

replaceFizzBuzzWithFizzbuzz :: Free FizzBuzz a -> Free FizzBuzz a
replaceFizzBuzzWithFizzbuzz (Free (Fizz (Free (Buzz cc)))) = do
  fizzbuzz
  replaceFizzBuzzWithFizzbuzz cc
replaceFizzBuzzWithFizzbuzz (Free fcc) = Free (fmap replaceFizzBuzzWithFizzbuzz fcc)
replaceFizzBuzzWithFizzbuzz (Pure a) = do
  pure a

-- do number  1
--    number  2
--    fizz
--    number  3
--    number  4
--    buzz
--    number  5
--    fizz
--    number  6
--    number  7
--    number  8
--    fizz
--    number  9
--    buzz
--    number 10
--    number 11
--    fizz
--    number 12
--    number 13
--    number 14
--    fizzbuzz
--    number 15

dropNumbersAfterZZs :: Free FizzBuzz a -> Free FizzBuzz a
dropNumbersAfterZZs (Free (Fizz (Free (Number _ cc)))) = do
  fizz
  dropNumbersAfterZZs cc
dropNumbersAfterZZs (Free (Buzz (Free (Number _ cc)))) = do
  buzz
  dropNumbersAfterZZs cc
dropNumbersAfterZZs (Free (Fizzbuzz (Free (Number _ cc)))) = do
  fizzbuzz
  dropNumbersAfterZZs cc
dropNumbersAfterZZs (Free fcc) = Free (fmap dropNumbersAfterZZs fcc)
dropNumbersAfterZZs (Pure a) = do
  pure a

-- do number  1
--    number  2
--    fizz
--    number  4
--    buzz
--    fizz
--    number  7
--    number  8
--    fizz
--    buzz
--    number 11
--    fizz
--    number 13
--    number 14
--    fizzbuzz

fizzBuzzToIO :: Free FizzBuzz a -> IO a
fizzBuzzToIO (Free (Fizz cc)) = do
  putStrLn "fizz"
  fizzBuzzToIO cc
fizzBuzzToIO (Free (Buzz cc)) = do
  putStrLn "buzz"
  fizzBuzzToIO cc
fizzBuzzToIO (Free (Fizzbuzz cc)) = do
  putStrLn "fizzbuzz"
  fizzBuzzToIO cc
fizzBuzzToIO (Free (Number i cc)) = do
  print i
  fizzBuzzToIO cc
fizzBuzzToIO (Pure a) = do
  pure a

-- do print  1
--    print  2
--    putStrLn "fizz"
--    print  4
--    putStrLn "buzz"
--    putStrLn "fizz"
--    print  7
--    print  8
--    putStrLn "fizz"
--    putStrLn "buzz"
--    print 11
--    putStrLn "fizz"
--    print 13
--    print 14
--    putStrLn "fizzbuzz"

main :: IO ()
main = fizzBuzzToIO
     $ dropNumbersAfterZZs
     $ replaceFizzBuzzWithFizzbuzz
     $ addFizzesAndBuzzes
     $ oneToOneHundred

































































































instance Functor FizzBuzz where
  fmap f (Fizz     r) = Fizz     (f r)
  fmap f (Buzz     r) = Buzz     (f r)
  fmap f (Fizzbuzz r) = Fizzbuzz (f r)
  fmap f (Number i r) = Number i (f r)
