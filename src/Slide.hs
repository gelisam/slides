{-# OPTIONS -fno-full-laziness #-}
module Slide where

import Data.IORef
import System.IO.Unsafe (unsafePerformIO)

{-# NOINLINE mkUniqueState #-}
mkUniqueState :: Int -> IORef Int
mkUniqueState _ = unsafePerformIO (newIORef 0)

-- |
-- >>> main
-- 0            (not really)
-- 0
main :: IO ()
main = do
  modifyIORef (mkUniqueState 0) (+1)
  print =<< readIORef (mkUniqueState 1)

  modifyIORef (mkUniqueState 2) (+1)
  print =<< readIORef (mkUniqueState 3)
