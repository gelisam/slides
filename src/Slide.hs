module Slide where
import Prelude hiding (Maybe(..), Monoid(..), Monad(..))

-- free Default
data Maybe a = Nothing | Just a

class Default a where
  def :: a


-- free Monoid
data List a = Nil | Cons a (List a)

class Monoid a where
  mempty  :: a
  mappend :: a -> a -> a


-- free Monad
data Free f a = Pure a | Deep (f (Free f a))

class Functor m => Monad m where
  return :: a -> m a
  (>>=)  :: m a -> (a -> m b) -> m b

























































































main :: IO ()
main = putStrLn "typechecks."
