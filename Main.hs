{-# LANGUAGE GADTs #-}
import Prelude hiding (Monoid(..), Monad(..))

-- mx >>= return = mx
-- return x >>= f = f x
-- (mx >>= f) >>= g = mx >>= (\x -> f x >>= g)
class Monad m where
    return :: a -> m a
    (>>=)  :: m a -> (a -> m b) -> m b

data MonadAST m a where
    MBase   :: m a -> MonadAST m a
    MReturn :: a -> MonadAST m a
    MBind   :: MonadAST m a -> (a -> MonadAST m b) -> MonadAST m b

data FreeMonad m a where
    MNil  :: a -> FreeMonad m a
    MCons :: m a -> (a -> FreeMonad m b) -> FreeMonad m b

instance Monad (FreeMonad m) where
    return = MNil
    MNil x      >>= f = f x
    MCons mx cc >>= f = MCons mx $ fmap (>>= f) cc

singletonM :: m a -> FreeMonad m a
singletonM mx = MCons mx MNil












































































































main :: IO ()
main = putStrLn "typechecks."
