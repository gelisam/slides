import Control.DeepSeq
import Control.Monad
import Control.Monad.Free
import Test.DocTest

-- |
-- >>> numbers
-- Free (1,Free (2,Free (3,Free (4,Pure ()))))
numbers :: Free ((,) Int) ()
numbers = do tell 1
             tell 2
             tell 3
             tell 4

tell :: w -> Free ((,) w) ()
tell w = liftF (w, ())



















































instance NFData a => NFData (Free Maybe a) where
  rnf (Pure x) = rnf x
  rnf (Free x) = rnf x


main :: IO ()
main = doctest ["-XFlexibleInstances", "-XInstanceSigs", "-XRankNTypes", "src/Main.hs"]
