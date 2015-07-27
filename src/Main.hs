





derefIncr :: GuardInScope (Just Int) (Just Int) ()


main :: IO ()
main = do
   lock_x <- newMutex (0 :: Int)
   _cmd0 :: IO ()
   
   withUninitializedGuard $ do
     _cmd1       :: GuardInScope Nothing    Nothing    ()
     lock lock_x :: GuardInScope Nothing    (Just Int) ()
     
     derefIncr   :: GuardInScope (Just Int) (Just Int) ()
     
     moveOut     :: GuardInScope (Just Int) Nothing    ()
     _cmd3       :: GuardInScope Nothing    Nothing    ()
     moveIn      :: GuardInScope Nothing    (Just Int) ()
     
     derefIncr   :: GuardInScope (Just Int) (Just Int) ()
































































































