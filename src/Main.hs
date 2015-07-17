import Control.Concurrent.MVar
import Data.IORef
import Text.Printf


main :: IO ()
main = do
   lock_x <- do ref_x <- newIORef (0 :: Int)
                newMVar ref_x
   ref <- newIORef Nothing
   
   withMVar lock_x $ \ref_x -> do
     x <- readIORef ref_x
     if x < 10 then modifyIORef ref_x (+1)
               else modifyIORef ref_x (+10)
     writeIORef ref (Just ref_x)
   
   withMVar lock_x $ \ref_x -> do
     
     printf "x is now %d" =<< readIORef ref_x
