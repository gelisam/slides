module Slide where
import Prelude hiding (Maybe(..), Monoid(..), Monad(..))

-- free Default
data Maybe a = Nothing | Just a

embedInMaybe :: a -> Maybe a
embedInMaybe a = Just a


-- free Monoid
data List a = Nil | Cons a (List a)

embedInList :: a -> List a
embedInList a = Cons a Nil



-- free Monad
data Free f a = Pure a | Deep (f (Free f a))

embedInFree :: Functor f
            => f a -> Free f a
embedInFree fa = Deep (fmap Pure fa)























































































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
