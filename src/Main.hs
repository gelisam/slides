





data Mutex a

newMutex :: a -> IO (Mutex a)

withGuard :: Mutex s -> GuardInScope (Just s) (Just s) a -> IO a
withGuard _ _ = do
    lock
    ...
    unlock

withUninitializedGuard :: GuardInScope Nothing (Just s) a -> IO a
withUninitializedGuard _ = do
    ...
    unlock































































































main = putStrLn "typechecks."
