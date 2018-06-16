import Data.Char
import Test.DocTest

newtype Yoneda f a = Yoneda
  { unYoneda :: forall r. (a -> r) -> f r }

-- (<$>)    :: forall a r. (a -> r) -> f a -> f r
-- (<$> fx) :: forall   r. (a -> r) ->        f r

makeYoneda :: Functor f => f a -> Yoneda f a
makeYoneda fa = Yoneda (<$> fa) 

fromYoneda :: Yoneda f a -> f a
fromYoneda ya = unYoneda ya id

-- |
-- >>> unYoneda foo id
-- "foo"
-- >>> unYoneda foo toUpper
-- "FOO"
foo :: Yoneda [] Char
foo = makeYoneda "foo"

























































main :: IO ()
main = doctest ["-XRankNTypes", "src/Main.hs"]
