module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad

-- >>> helloInputIO
-- What is your name?
-- <user types "Sam">
-- Hello, Sam
helloInputIO :: IO ()
helloInputIO = do putStrLn "What is your name?"
                  name <- getLine
                  putStrLn ("Hello, " ++ name)

-- >>> manyInputsIO
-- How many numbers?
-- <user types 2>
-- Enter 2 numbers:
-- <user types "100">
-- <user types "200">
-- Their sum is 300
manyInputsIO :: IO ()
manyInputsIO = do putStrLn "How many numbers?"
                  n <- read <$> getLine
                  putStrLn ("Enter " ++ show n ++ " numbers:")
                  xs <- replicateM n (read <$> getLine)
                  putStrLn ("Their sum is " ++ show (sum xs))



































































































main :: IO ()
main = doctest ["src/Slide.hs"]
