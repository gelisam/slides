import Control.Concurrent.MVar
import Data.IORef
import Text.Printf

main :: IO ()
main = do
   lock_x <- newMVar ()
   
   
   withMVar    lock_x $ \() -> do
     
     modifyIORef ref_x (+1)
     
   
   
   withMVar lock_x $ \() -> do
     
     printf "x is now %d" =<< readIORef ref_x
