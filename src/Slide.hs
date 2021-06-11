{-# OPTIONS -fno-cse #-}
module Slide where

import Data.IORef
import System.IO.Unsafe (unsafePerformIO)





-- |
-- >>> main
-- 0
-- 0
main :: IO ()
main = do
  modifyIORef (unsafePerformIO (newIORef 0)) (+1)
  print =<< readIORef (unsafePerformIO (newIORef 0))

  modifyIORef (unsafePerformIO (newIORef 0)) (+1)
  print =<< readIORef (unsafePerformIO (newIORef 0))
