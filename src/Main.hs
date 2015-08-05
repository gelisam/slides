{-# LANGUAGE DataKinds, GADTs, KindSignatures, PolyKinds, ScopedTypeVariables, TypeFamilies #-}

import Prelude hiding (return, (>>=))

import Control.Concurrent.MVar
import Control.Monad.Trans.State
import Data.IORef



data Mutex a = Mutex (MVar (IORef a))

newMutex :: a -> IO (Mutex a)
newMutex x = do
    ref <- newIORef x
    mvar <- newMVar ref
    return (Mutex mvar)

touchMutex :: Mutex a -> IO ()
touchMutex (Mutex _) = return ()

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
    Bind :: FreeIxMonad f i j a -> (a -> FreeIxMonad f j k b) -> FreeIxMonad f i k b
    Lift :: f i j a -> FreeIxMonad f i j a

return :: a -> FreeIxMonad f i i a
return = Return

(>>=) :: FreeIxMonad f i j a -> (a -> FreeIxMonad f j k b) -> FreeIxMonad f i k b
(>>=) = Bind


type UnindexedOp m i j a = m a
type Unindexed m a = FreeIxMonad (UnindexedOp m) '() '() a


data GuardInScopeOp i j a where
    Lock   :: Mutex s   -> GuardInScopeOp 'Nothing  ('Just s) ()
    Deref  :: State s a -> GuardInScopeOp ('Just s) ('Just s) a
    Unlock ::              GuardInScopeOp ('Just s) 'Nothing  ()

type GuardInScope = FreeIxMonad GuardInScopeOp


type family MaybeMutex i where
    MaybeMutex 'Nothing = ()
    MaybeMutex ('Just s) = Mutex s

runGuardInScope :: GuardInScope i j a -> MaybeMutex i -> IO (a, MaybeMutex j)
runGuardInScope (Return x)  mi = return (x, mi)
runGuardInScope (Bind gx f) mi = do
    (x, mj) <- runGuardInScope gx mi
    runGuardInScope (f x) mj
runGuardInScope (Lift (Lock mj)) () = do
    touchMutex mj
    return ((), mj)
runGuardInScope (Lift (Deref _)) mi = do
    touchMutex mi
    return (undefined, mi)
runGuardInScope (Lift Unlock) mi = do
    touchMutex mi
    return ((), ())


lock :: Mutex s -> GuardInScope 'Nothing ('Just s) ()
lock = Lift . Lock

deref :: State s a -> GuardInScope ('Just s) ('Just s) a
deref = Lift . Deref

unlock :: GuardInScope ('Just s) 'Nothing ()
unlock = Lift Unlock


class UnlockIfNeeded i where
    unlockIfNeeded :: GuardInScope i 'Nothing ()

instance UnlockIfNeeded 'Nothing where
    unlockIfNeeded = Return ()

instance UnlockIfNeeded ('Just s) where
    unlockIfNeeded = unlock

withUninitializedGuard :: UnlockIfNeeded j
                       => GuardInScope 'Nothing j a
                       -> IO a
withUninitializedGuard body = do
    (x, ()) <- runGuardInScope (body `Bind` (\x -> unlockIfNeeded `Bind` (\_ -> Return x))) ()
    return x

























































































main :: IO ()
main = putStrLn "typechecks."
