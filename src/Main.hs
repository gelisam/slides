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
forUpTo n act = go 1
  where
    go i = unless (i >= n) $ do
      act i
      go (i+1)

-- tell 1 >> (tell 2 >> (tell 3 >> (tell 4 >> pure ())))




















































instance (NFData a, NFData b) => NFData (Free ((,) a) b) where
  rnf (Pure x) = rnf x
  rnf (Free x) = rnf x


tell :: w -> Free ((,) w) ()
tell w = liftF (w, ())


main :: IO ()
main = doctest ["-XFlexibleInstances", "-XInstanceSigs", "-XRankNTypes", "src/Main.hs"]
