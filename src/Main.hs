{-# LANGUAGE DataKinds, GADTs, KindSignatures, PolyKinds #-}

import Control.Concurrent.MVar
import Control.Monad.Trans.State
import Data.IORef



data Mutex a = Mutex (MVar (IORef a))

newMutex :: a -> IO (Mutex a)
newMutex x = do
    ref <- newIORef x
    mvar <- newMVar ref
    return (Mutex mvar)

-- withUninitializedGuard :: GuardInScope False True () -> IO ()
-- withUninitializedGuard (Mutex mvar) body = do
--     ref <- liftIO $ takeMVar mvar
--     s <- liftIO $ readIORef ref
--     (x, s') <- runStateT body s
--     liftIO $ writeIORef ref s'
--     liftIO $ putMVar mvar ref
--     return x


data FreeIxMonad f i j a where
    Return :: a -> FreeIxMonad f i i a
    Bind :: FreeIxMonad f i j a -> (a -> FreeIxMonad f j k b) -> FreeIxMonad f i j b
    Lift :: f i j a -> FreeIxMonad f i j a

data GuardInScopeOp i j a where
    Lock   :: Mutex s   -> GuardInScopeOp 'Nothing  ('Just s) ()
    Deref  :: State s a -> GuardInScopeOp ('Just s) ('Just s) a
    Unlock ::              GuardInScopeOp ('Just s) 'Nothing  ()

type GuardInScope = FreeIxMonad GuardInScopeOp

lock :: Mutex s -> FreeIxMonad GuardInScopeOp 'Nothing ('Just s) ()
lock = Lift . Lock

deref :: State s a -> FreeIxMonad GuardInScopeOp ('Just s) ('Just s) a
deref = Lift . Deref

unlock :: FreeIxMonad GuardInScopeOp ('Just s) 'Nothing ()
unlock = Lift Unlock
































































































main :: IO ()
main = putStrLn "typechecks."
