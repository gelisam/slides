





derefIncr :: GuardInScope True ()


main :: IO ()
main = do
   lock_x <- newMutex (0 :: Int)
   _cmd0 :: IO ()
   
   withUninitializedGuard $ do
     _cmd1       :: GuardInScope False ()
     lock lock_x
     
     derefIncr   :: GuardInScope True  ()
     
     moveOut
     _cmd3       :: GuardInScope False ()
     moveIn
     
     derefIncr   :: GuardInScope True  ()
































































































