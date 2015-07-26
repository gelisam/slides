{-# LANGUAGE DataKinds, KindSignatures #-}





data Mutex a

newMutex :: a -> IO (Mutex a)

-- withMutex :: Mutex s -> State s a -> IO a

withUninitializedGuard :: GuardInScope False True () -> IO ()


data GuardInScope (i :: Bool) (j :: Bool) a

-- unlock lock_x :: GuardInScope False True  ()
-- derefIncr     :: GuardInScope True  True  ()
-- 
-- moveOut       :: GuardInScope True  False ()
-- moveIn        :: GuardInScope False True  ()
































































































main = putStrLn "typechecks."
