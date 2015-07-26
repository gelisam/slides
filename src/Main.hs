{-# LANGUAGE DataKinds, KindSignatures #-}





data Mutex a = Mutex (MVar (IORef a))

newMutex :: a -> IO (Mutex a)
newMutex x = do
    ref <- newIORef x
    mvar <- newMVar ref
    return (Mutex mvar)

withMutex :: (Monad m, MonadIO m)
          => Mutex s -> StateT s m a -> m a
withMutex (Mutex mvar) body = do
    ref <- liftIO $ takeMVar mvar
    s <- liftIO $ readIORef ref
    (x, s') <- runStateT body s
    liftIO $ writeIORef ref s'
    liftIO $ putMVar mvar ref
    return x


data GuardInScope (i :: Bool) (j :: Bool) a

-- unlock lock_x :: GuardInScope False True  ()
-- derefIncr     :: GuardInScope True  True  ()
-- 
-- moveOut       :: GuardInScope True  False ()
-- moveIn        :: GuardInScope False True  ()
































































































main = putStrLn "typechecks."
