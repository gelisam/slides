import Control.DeepSeq
import Control.Monad
import Control.Monad.Free
import Test.DocTest

-- |
-- >>> :set +s
-- >>> rnf computation
computation :: Free ((,) Int) ()
computation = forUpTo 5000 tell

forUpTo :: Monad m => Int -> (Int -> m ()) -> m ()
forUpTo 0 _   = pure ()
forUpTo n act = do forUpTo (n-1) act
                   act n

-- (((pure () >> tell 1) >> tell 2) >> tell 3) >> tell 4



















































instance (NFData a, NFData b) => NFData (Free ((,) a) b) where
  rnf (Pure x) = rnf x
  rnf (Free x) = rnf x


tell :: w -> Free ((,) w) ()
tell w = liftF (w, ())


main :: IO ()
main = doctest ["-XFlexibleInstances", "-XInstanceSigs", "-XRankNTypes", "src/Main.hs"]
