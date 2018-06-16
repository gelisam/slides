import Data.Char
import Test.DocTest

newtype Yoneda f a = Yoneda
  { unYoneda :: forall r. (a -> r) -> f r }

-- |
-- >>> fromYoneda . fmap toUpper . makeYoneda $ "foo"
-- "FOO"
instance Functor (Yoneda f) where
  fmap :: (a -> b) -> Yoneda f a -> Yoneda f b
  fmap a2b ya = undefined























































makeYoneda :: Functor f => f a -> Yoneda f a
makeYoneda fx = Yoneda (<$> fx) 

fromYoneda :: Yoneda f a -> f a
fromYoneda yx = unYoneda yx id


main :: IO ()
main = doctest ["-XInstanceSigs", "-XRankNTypes", "src/Main.hs"]
