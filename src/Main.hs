





derefIncr :: GuardInScope (Just Int) ()


main :: IO ()
main = do
   lock_x <- newMutex (0 :: Int)
   _cmd0 :: IO ()
   
   withUninitializedGuard $ do
     _cmd1       :: GuardInScope Nothing    ()
     lock lock_x
     
     derefIncr   :: GuardInScope (Just Int) ()
     
     moveOut
     _cmd3       :: GuardInScope Nothing    ()
     moveIn
     
     derefIncr   :: GuardInScope (Just Int) ()
































































































