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
   
   
   withMutex lock_x $ do
     withMutex lock_y $ do
       x <- lift get
       y <- get
       lift $ modify (+1)
       modify (+10)
   
   
   
   x <- withMutex lock_x get
   y <- withMutex lock_y get
   
   
   printf "x is now %d, y is now %d" x y
   
   
data Mutex a = Mutex (MVar (IORef a))

newMutex :: a -> IO (Mutex a)
newMutex x = do
    ref <- newIORef x
    mvar <- newMVar ref
    return (Mutex mvar)

withMutex ::                     
             Mutex s -> State  s   a -> IO a
withMutex (Mutex mvar) body = do
    ref <-          takeMVar mvar
    s <-          readIORef ref
    let (x, s') = runState body s
             writeIORef ref s'
             putMVar mvar ref
    return x
































































































