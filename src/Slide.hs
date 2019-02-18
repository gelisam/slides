module Slide where
import Prelude hiding (Maybe(..), Monoid(..), Monad(..))

-- free Default
data Maybe a = Nothing | Just a

instance Default (Maybe a) where
  def = Nothing


-- free Monoid
data List a = Nil | Cons a (List a)

instance Monoid (List a) where
  mempty = Nil
  mappend Nil         ys = ys
  mappend (Cons x xs) ys = Cons x (mappend xs ys)

-- free Monad
data Free f a = Pure a | Deep (f (Free f a))

instance Functor f => Monad (Free f) where
  return = Pure
  Pure a     >>= cc = cc a
  Deep fFree >>= cc = Deep (fmap (>>= cc) fFree)























































































class Default a where
  def :: a

class Monoid a where
  mempty  :: a
  mappend :: a -> a -> a

class Functor m => Monad m where
  return :: a -> m a
  (>>=)  :: m a -> (a -> m b) -> m b

instance Functor f => Functor (Free f) where
  fmap f (Pure a)     = Pure (f a)
  fmap f (Deep fFree) = Deep (fmap (fmap f) fFree)


main :: IO ()
main = putStrLn "typechecks."
