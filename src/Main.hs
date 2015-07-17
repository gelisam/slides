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


data HandleMonad a
  = HandleReturn a
  | HandlePutStrLn String (HandleMonad a)
  | HandleGetLine (String -> HandleMonad a)

runHandleMonad :: HandleMonad a -> Handle -> IO a
runHandleMonad (HandleReturn x)      _ = return x
runHandleMonad (HandlePutStrLn s cc) h = do hPutStrLn h s
                                            runHandleMonad cc h
runHandleMonad (HandleGetLine    cc) h = do s <- hGetLine h
                                            runHandleMonad (cc s) h

instance Functor HandleMonad where
  fmap f (HandleReturn x)      = HandleReturn (f x)
  fmap f (HandlePutStrLn s cc) = HandlePutStrLn s (fmap f cc)
  fmap f (HandleGetLine    cc) = HandleGetLine    (fmap (fmap f) cc)

instance Applicative HandleMonad where
  pure = return
  (<*>) = ap

instance Monad HandleMonad where
  return = HandleReturn
  HandleReturn x      >>= f = f x
  HandlePutStrLn s cc >>= f = HandlePutStrLn s (cc >>= f)
  HandleGetLine    cc >>= f = HandleGetLine    (fmap (>>= f) cc)

handlePutStrLn :: String -> HandleMonad ()
handlePutStrLn s = HandlePutStrLn s (return ())

handleGetLine :: HandleMonad String
handleGetLine = HandleGetLine return






















































































