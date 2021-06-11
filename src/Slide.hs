{-# OPTIONS -fno-full-laziness -ddump-simpl-iterations -dsuppress-module-prefixes -dsuppress-uniques #-}
module Slide where

import Data.IORef
import System.IO.Unsafe (unsafePerformIO)

{-# NOINLINE mkUniqueState #-}
mkUniqueState :: Int -> IORef Int
mkUniqueState _ = unsafePerformIO (newIORef 0)

-- |
-- >>> main
-- 1            (but why??)
-- 2
main :: IO ()
main = do
  modifyIORef (mkUniqueState 0) (+1)
  print =<< readIORef (mkUniqueState 1)

  modifyIORef (mkUniqueState 2) (+1)
  print =<< readIORef (mkUniqueState 3)
