{-# LANGUAGE NumericUnderscores #-}
module Slide where

import Control.Concurrent.Async (concurrently_)
import Control.Exception (evaluate)
import Data.Foldable (forM_)
import Data.IORef
import System.IO.Unsafe (unsafeDupablePerformIO)

{-# NOINLINE doNothing #-}
doNothing :: Int -> IORef Int -> ()
doNothing i ref = unsafeDupablePerformIO $ do
  atomicModifyIORef' ref (\x -> (x + 1, ()))
  atomicModifyIORef' ref (\x -> (x - 1, ()))
  evaluate i
  pure ()

-- |
-- >>> main
-- 0     OR     <non-zero>
main :: IO ()
main = do
  ref <- newIORef 0
  forM_ [1..10_000] $ \i -> do
    let unit = doNothing i ref
    concurrently_
      (evaluate unit)
      (evaluate unit)
  print =<< readIORef ref
