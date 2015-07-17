import Control.Concurrent.MVar
import Data.IORef
import Text.Printf

main :: IO ()
main = do
   lock_x <- newMVar (0 :: Int)
   
   
   modifyMVar_ lock_x $ \x -> do
     
     let x' = x + 1
     return x'
   
   
   withMVar lock_x $ \x -> do
     
     printf "x is now %d" x
