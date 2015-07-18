import Control.Concurrent.MVar
import Control.Monad.Trans.State
import Data.IORef
import Text.Printf





main :: IO ()
main = do
   lock_x <- newMutex (0 :: Int)
   
   
   
   withMutex lock_x $ do
     x <- get
     modify (+1)
   
   
   
   x <- withMutex lock_x get
   
   printf "x is now %d" x
   
   
data Mutex a = Mutex (MVar (IORef a))

newMutex :: a -> IO (Mutex a)
newMutex x = do
    ref <- newIORef x
    mvar <- newMVar ref
    return (Mutex mvar)

withMutex :: Mutex s -> State s a -> IO a
withMutex (Mutex mvar) body = do
    ref <- takeMVar mvar
    s <- readIORef ref
    let (x, s') = runState body s
    writeIORef ref s'
    putMVar mvar ref
    return x
































































































