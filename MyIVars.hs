module MyIVars where

import Control.Concurrent.MVar
import Control.Monad


type IVar a = MVar a

newIVar :: IO (IVar a)
newIVar = newEmptyMVar

blockThenReadIVar :: IVar a -> IO a
blockThenReadIVar = readMVar

writeThenFreezeIVar :: IVar a -> a -> IO ()
writeThenFreezeIVar var x = do
    wasEmpty <- tryPutMVar var x
    unless wasEmpty $ fail "write after freeze"
