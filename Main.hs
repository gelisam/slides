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

data FreeMonad m a where                         -- data Free f a
    MNil  :: a -> FreeMonad m a                  --   = Pure a
    MCons :: m (FreeMonad m b) -> FreeMonad m b  --   | Free f (Free f)

instance Functor m => Monad (FreeMonad m) where
    return = MNil
    MNil x    >>= f = f x
    MCons mfx >>= f = MCons $ fmap (>>= f) mfx

singletonM :: Functor m => m a -> FreeMonad m a
singletonM mx = MCons (fmap MNil mx)












































































































main :: IO ()
main = putStrLn "typechecks."
