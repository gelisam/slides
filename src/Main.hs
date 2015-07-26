








main :: IO ()
main = do
   lock_x <- newMutex (0 :: Int)
   _cmd0 :: IO ()
   
   withUninitializedGuard $ do
     _cmd1 :: IO ()
     lock lock_x
     
     _cmd2 :: StateT (MutexGuard Int) IO ()
     
     moveOut
     _cmd3 :: IO ()
     moveIn
     
     _cmd4 :: StateT (MutexGuard Int) IO ()
































































































