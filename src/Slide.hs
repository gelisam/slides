module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad

-- helloInputAST = '(do (putStrLn   "What is your name?")
--                      (bind name getLine)
--                      (putStrLn   (mappend "Hello, " name)))
helloInputIO :: IO ()
helloInputIO = do
  putStrLn "What is your name?"
  name <- getLine
  putStrLn ("Hello, " ++ name)

-- manyInputsAST = '(do (putStrLn   "How many numbers?")
--                      (bind n (fmap read getLine))
--                      (putStrLn   (mappend "Enter "
--                                    (mappend (show n) " numbers:")))
--                      (bind xs (replicateM n (fmap read getLine)))
--                      (putStrLn   (mappend "Their sum is " (show (sum xs)))))
manyInputsIO :: IO ()
manyInputsIO = do
  putStrLn "How many numbers?"
  n <- read <$> getLine
  putStrLn ("Enter " ++ show n ++ " numbers:")
  xs <- replicateM n (read <$> getLine)
  putStrLn ("Their sum is " ++ show (sum xs))



































































































main :: IO ()
main = doctest ["src/Slide.hs"]
