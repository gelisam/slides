import Control.Concurrent.MVar
import Data.IORef
import System.IO
import Text.Printf

main :: IO ()
main = do
   lock_h <- newMVar stdout
   
   withMVar lock_h $ \h -> do
     hPutStrLn h "hello"
