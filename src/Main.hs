import Control.Concurrent.MVar
import Control.Monad.Trans.State
import Data.IORef
import Text.Printf

main :: IO ()
main = do
   lock_x <- do ref_x <- newIORef (0 :: Int)
                newMVar ref_x
   ref <- newIORef Nothing
   
   withMVar lock_x $           do
     x <- get
     if x < 10 then modify (+1)
               else modify (+10)
     
   
   withMVar lock_x $ \ref_x -> do
     
     printf "x is now %d" =<< readIORef ref_x
