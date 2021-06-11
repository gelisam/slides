
module Slide where

import Control.Exception
import Data.ByteString.Internal (accursedUnutterablePerformIO)
import Data.IORef
import System.IO.Unsafe (unsafePerformIO)

-- INLINE, not NOINLINE!
{-# INLINE increment #-}
increment :: IORef Int -> Int -> ()
increment ref i = accursedUnutterablePerformIO $ do
  modifyIORef ref (\x -> x + 100)
  modifyIORef ref (\x -> x + i)

-- |
-- >>> main            >>> main
-- 102          OR     102
-- 205                 105
main :: IO ()
main = do
  ref <- newIORef 0

  evaluate $ increment ref 2
  print =<< readIORef ref

  evaluate $ increment ref 3
  print =<< readIORef ref
