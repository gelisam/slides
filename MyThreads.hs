module MyThreads where

import Data.IORef
import Control.Concurrent hiding (ThreadId)
import Control.Concurrent.MVar


type ThreadId = MVar ()

-- from the docs of Control.Concurrent
forkIO :: IO () -> IO ThreadId
forkIO body = do
    threadId <- newEmptyMVar
    forkFinally body (\_ -> putMVar threadId ())
    return threadId

wait :: ThreadId -> IO ()
wait = takeMVar

atomicallyModify :: IORef a -> (a -> a) -> IO ()
atomicallyModify ref f = atomicModifyIORef' ref (\x -> (f x, ()))
