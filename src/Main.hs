import Control.Concurrent.MVar
import Data.IORef
import Text.Printf


main :: IO ()
main = do
   lock_x <- do ref_x <- newIORef (0 :: Int)
                newMVar ref_x
   
   
   withMVar lock_x $ \ref_x -> do
     
     modifyIORef ref_x (+1)
   
   
   withMVar lock_x $ \ref_x -> do
     
     printf "x is now %d" =<< readIORef ref_x
