
module Slide where

import Control.Exception
import Data.ByteString.Internal (accursedUnutterablePerformIO)
import Data.IORef
import System.IO.Unsafe (unsafePerformIO)






-- |
-- >>> main            >>> main
-- 102          OR     102
-- 205                 105
main :: IO ()
main = do
  ref <- newIORef 0
  let shared = accursedUnutterablePerformIO $ do
        modifyIORef ref (\x -> x + 100)

  evaluate $ accursedUnutterablePerformIO $ do
    evaluate shared
    modifyIORef ref (\x -> x + 2)
  print =<< readIORef ref

  evaluate $ accursedUnutterablePerformIO $ do
    evaluate shared
    modifyIORef ref (\x -> x + 3)
  print =<< readIORef ref
