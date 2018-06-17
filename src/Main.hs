import Control.DeepSeq
import Control.Monad
import Control.Monad.Free
import Test.DocTest

-- |
-- >>> :set +s
-- >>> rnf computation
computation :: Free ((,) Int) ()
computation = fastUpTo 5000 tell

forUpTo :: Monad m => Int -> (Int -> m ()) -> m ()
forUpTo 0 _   = pure ()
forUpTo n act = do forUpTo (n-1) act
                   act n

fastUpTo :: Monad m => Int -> (Int -> m ()) -> m ()
fastUpTo n act = fromCodensity $ forUpTo n (makeCodensity . act)



















































data Codensity m a = Codensity
  { unCodensity :: forall r. (a -> m r) -> m r }

instance Functor m => Functor (Codensity m) where
  fmap a2b ca = Codensity $ \b2mr
             -> unCodensity ca (b2mr . a2b)

instance Applicative m => Applicative (Codensity m) where
  pure x = Codensity ($ x)
  cf <*> ca = Codensity $ \b2mr
           -> unCodensity cf $ \f
           -> unCodensity ca $ \a
           -> b2mr (f a)

instance Monad m => Monad (Codensity m) where
  ca >>= a2cb = Codensity $ \b2mr
             -> unCodensity ca $ \a
             -> unCodensity (a2cb a) b2mr

makeCodensity :: Monad m => m a -> Codensity m a
makeCodensity mx = Codensity (mx >>=)

fromCodensity :: Monad m => Codensity m a -> m a
fromCodensity cx = unCodensity cx pure


instance (NFData a, NFData b) => NFData (Free ((,) a) b) where
  rnf (Pure x) = rnf x
  rnf (Free x) = rnf x


tell :: w -> Free ((,) w) ()
tell w = liftF (w, ())


main :: IO ()
main = doctest ["-XFlexibleInstances", "-XInstanceSigs", "-XRankNTypes", "src/Main.hs"]
