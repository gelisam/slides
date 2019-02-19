module Slide where
import Test.DocTest                                                                                                    ; import Data.Foldable

-- |
-- >>> helloWorldIO
-- hello
-- world
helloWorldIO :: IO ()
helloWorldIO = do putStrLn "hello"
                  putStrLn "world"

-- |
-- >>> manyNumbersIO
-- 1
-- 2
-- 3
-- 4
-- 5
manyNumbersIO :: IO ()
manyNumbersIO = for_ [1..5] $ \i -> do
                  putStrLn (show i)



































































































main :: IO ()
main = doctest ["src/Slide.hs"]
