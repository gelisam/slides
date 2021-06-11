
module Slide where

import Data.IORef
import System.IO.Unsafe (unsafePerformIO)



-- |
-- >>> main
-- 1            (in practice)
-- 2
main :: IO ()
main = do
  let s = unsafePerformIO (newIORef 0)

  modifyIORef s (+1)
  print =<< readIORef s

  modifyIORef s (+1)
  print =<< readIORef s
