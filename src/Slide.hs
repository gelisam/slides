
module Slide where

import System.IO.Unsafe (unsafePerformIO)


trace :: String -> a -> a
trace s a = unsafePerformIO $ do
  putStrLn s
  pure a

-- |
-- >>> main
-- hello
-- world
-- 2
main :: IO ()
main = do
  print (trace "hello" 1 + trace "world" 2 :: Int)
