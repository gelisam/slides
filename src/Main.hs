import Control.Applicative
import Control.Concurrent
import Control.Concurrent.MVar
import Control.Monad
import Control.Monad.Trans.State
import Data.IORef
import Text.Printf
import System.IO


data MutexHandle = Mutex (MVar Handle)

newMutexHandle :: Handle -> IO MutexHandle
newMutexHandle h = do
    
    mvar <- newMVar h
    return (Mutex mvar)

withMutexHandle :: MutexHandle -> HandleMonad a -> IO a
withMutexHandle (Mutex mvar) body = do
    h   <- takeMVar mvar
    
    x <- runHandleMonad body h
    
    putMVar mvar h
    return x


main :: IO ()
main = do
   lock_h <- newMutexHandle stdout
   
   forkIO $ forever $ do
     withMutexHandle lock_h $ do
       handlePutStrLn "hello"
   
   forever $ do
     withMutexHandle lock_h $ do
       handlePutStrLn "world"































































































