
module Slide where

import Data.IORef
import System.IO.Unsafe (unsafePerformIO)


globalState :: IORef Int
globalState = unsafePerformIO (newIORef 0)

-- |
-- >>> main            >>> main            >>> main
-- 1            OR     0            OR     1
-- 2                   0                   1
main :: IO ()
main = do
  modifyIORef globalState (+1)
  print =<< readIORef globalState

  modifyIORef globalState (+1)
  print =<< readIORef globalState
