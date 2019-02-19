module Slide where
import Test.DocTest                                                                                                    ; import Data.Foldable

-- helloWorldAST = '(do (putStrLn "hello")
--                      (putStrLn "world"))
helloWorldIO :: IO ()
helloWorldIO = do putStrLn "hello"
                  putStrLn "world"

-- manyNumbersAST = '(for_ (enumFromTo 1 5) (lambda (i) (do
--                     (putStrLn (show i)))))
manyNumbersIO :: IO ()
manyNumbersIO = for_ [1..5] $ \i -> do
                  putStrLn (show i)



































































































main :: IO ()
main = doctest ["src/Slide.hs"]
