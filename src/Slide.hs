
module Slide where

import Data.IORef
import System.IO.Unsafe (unsafePerformIO)


globalState :: IORef Int
globalState = unsafePerformIO (newIORef 0)

-- |
-- >>> main
-- 1            (not really)
-- 2
main :: IO ()
main = do
  modifyIORef globalState (+1)
  print =<< readIORef globalState

  modifyIORef globalState (+1)
  print =<< readIORef globalState
