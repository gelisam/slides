





derefIncr :: StateT (MutexGuard Int) IO ()


main :: IO ()
main = do
   lock_x <- newMutex (0 :: Int)
   _cmd0 :: IO ()
   
   withUninitializedGuard $ do
     _cmd1     :: IO ()
     lock lock_x
     
     derefIncr :: StateT (MutexGuard Int) IO ()
     
     moveOut
     _cmd3     :: IO ()
     moveIn
     
     derefIncr :: StateT (MutexGuard Int) IO ()
































































































