
module Slide where

import Control.Exception (evaluate)
import Data.IORef
import System.IO.Unsafe (unsafePerformIO)

{-# NOINLINE mkUniqueState #-}
mkUniqueState :: Int -> IORef Int
mkUniqueState i = unsafePerformIO $ do
  r <- newIORef 0
  evaluate i
  pure r

-- |
-- >>> main
-- 0            (finally!!)
-- 0
main :: IO ()
main = do
  modifyIORef (mkUniqueState 0) (+1)
  print =<< readIORef (mkUniqueState 1)

  modifyIORef (mkUniqueState 2) (+1)
  print =<< readIORef (mkUniqueState 3)
