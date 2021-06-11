
module Slide where

import Data.IORef
import System.IO.Unsafe (unsafePerformIO)

{-# NOINLINE mkUniqueState #-}
globalState = unsafePerformIO (newIORef 0)
mkUniqueState _ = globalState

-- |
-- >>> main
-- 1            (in practice)
-- 2
main :: IO ()
main = do
  modifyIORef (mkUniqueState 0) (+1)
  print =<< readIORef (mkUniqueState 1)

  modifyIORef (mkUniqueState 2) (+1)
  print =<< readIORef (mkUniqueState 3)
