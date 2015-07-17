import Control.Concurrent.MVar
import Control.Monad.Trans.State
import Data.IORef
import Text.Printf


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


main :: IO ()
main = do
   lock_x <- newMutex (0 :: Int)
   
   
   withMutex lock_x $           do
     x <- get
     if x < 10 then modify            (+1)
               else modify            (+10)
   
   






























































































