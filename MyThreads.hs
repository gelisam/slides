module MyThreads where

import Data.IORef
import Control.Concurrent hiding (ThreadId)
import Control.Concurrent.MVar
import Control.Exception.Base


type ThreadId = MVar (Either SomeException ())

-- from the docs of Control.Concurrent
forkIO :: IO () -> IO ThreadId
forkIO body = do
    threadId <- newEmptyMVar
    forkFinally body (putMVar threadId)
    return threadId

wait :: ThreadId -> IO ()
wait threadId = do
    r <- takeMVar threadId
    case r of
      Left e -> throwIO e
      Right () -> return ()
