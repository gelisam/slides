
import Data.IORef
import Text.Printf

main :: IO ()
main = do
   ref_x <- newIORef (0 :: Int)
   
   modifyIORef ref_x (+1)
   
   printf "x is now %d" =<< readIORef ref_x
