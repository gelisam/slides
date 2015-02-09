module MyLVars where

import Control.Concurrent.MVar
import Control.Monad


type LVar a = MVar (a, Bool)

newLVar :: a -> IO (LVar a)
newLVar x = newMVar (x, False)

freezeThenReadLVar :: LVar a -> IO a
freezeThenReadLVar var = do
    (x, _) <- takeMVar var
    putMVar var (x, True)
    return x

atomicallyModify :: LVar a -> (a -> a) -> IO ()
atomicallyModify var f = do
    (x, frozen) <- takeMVar var
    if frozen
    then putMVar var (x, frozen) >> fail "write after freeze"
    else putMVar var (f x, frozen)
