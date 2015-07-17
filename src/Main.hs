import Control.Concurrent
import Control.Concurrent.MVar
import Control.Monad
import Data.IORef
import System.IO
import Text.Printf

main :: IO ()
main = do
   lock_h <- newMVar stdout
   ref_h <- newIORef Nothing
   
   forkIO $ forever $ do
     withMVar lock_h $ \h -> do
       writeIORef ref_h (Just h)
       hPutStrLn h "hello"
   
   Just h <- readIORef ref_h
   forever $ do
     hPutStrLn h "world"
