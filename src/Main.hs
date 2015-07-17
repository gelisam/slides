import Control.Concurrent.MVar
import Data.IORef
import Text.Printf

main :: IO ()
main = do
   ref_x <- newIORef (0 :: Int)
   lock_x <- newMVar ()
   
   do
     () <- takeMVar lock_x
     modifyIORef ref_x (+1)
     putMVar lock_x ()
   
   do
     () <- takeMVar lock_x
     printf "x is now %d" =<< readIORef ref_x
     putMVar lock_x ()
