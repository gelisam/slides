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

































































































main :: IO ()
main = return ()
