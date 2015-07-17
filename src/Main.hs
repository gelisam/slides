import Control.Concurrent
import Control.Concurrent.MVar
import Control.Monad
import Data.IORef
import System.IO
import Text.Printf

main :: IO ()
main = do
   lock_h <- newMVar stdout
   
   forkIO $ forever $ do
     withMVar lock_h $ \h -> do
       hPutStrLn h "hello"
   
   forever $ do
     withMVar lock_h $ \h -> do
       hPutStrLn h "world"
