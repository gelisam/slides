import Control.Concurrent.MVar
import Control.Monad.IO.Class
import Control.Monad.Trans.Class
import Control.Monad.Trans.State
import Data.IORef
import Text.Printf



main :: IO ()
main = do
   lock_x <- newMutex (0 :: Int)
   lock_y <- newMutex (100 :: Int)
   
   
   _cmd0 :: IO ()
   withMutex lock_x $ do
     _cmd1 :: StateT Int IO ()
     withMutex lock_y $ do
       x <- lift get
       y <- get
       lift $ modify (+1)
       modify (+10)
   
   
   
   withMutex lock_x $ do
     withMutex lock_y $ do
       x <- lift get
       y <- get
       liftIO $ printf "x is now %d, y is now %d" x y
   
   
data Mutex a = Mutex (MVar (IORef a))

newMutex :: a -> IO (Mutex a)
newMutex x = do
    ref <- newIORef x
    mvar <- newMVar ref
    return (Mutex mvar)

withMutex :: (Monad m, MonadIO m)
          => Mutex s -> StateT s m a -> m a
withMutex (Mutex mvar) body = do
    ref <- liftIO $ takeMVar mvar
    s <- liftIO $ readIORef ref
    (x, s') <- runStateT body s
    liftIO $ writeIORef ref s'
    liftIO $ putMVar mvar ref
    return x
































































































