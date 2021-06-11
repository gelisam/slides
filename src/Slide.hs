{-# OPTIONS -ddump-simpl -dsuppress-module-prefixes -dsuppress-uniques #-}
module Slide where

import Data.IORef
import System.IO.Unsafe (unsafePerformIO)





-- |
-- >>> main            >>> main            >>> main
-- 0            OR     1            OR     1
-- 0                   2                   1
main :: IO ()
main = do
  modifyIORef (unsafePerformIO (newIORef 0)) (+1)
  print =<< readIORef (unsafePerformIO (newIORef 0))

  modifyIORef (unsafePerformIO (newIORef 0)) (+1)
  print =<< readIORef (unsafePerformIO (newIORef 0))
