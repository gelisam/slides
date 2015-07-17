import Control.Concurrent
import Control.Concurrent.MVar
import Control.Monad
import Data.IORef
import System.IO
import Text.Printf

main :: IO ()
main = do
   let h = stdout
   
   forkIO $ forever $ do
     hPutStrLn h "hello"
   
   
   forever $ do
     hPutStrLn h "world"
