module Slide where

toDefaultHomomorphism :: Default b
                      => (a -> b) -> Maybe a -> b
toDefaultHomomorphism _ Nothing  = def
toDefaultHomomorphism f (Just a) = f a

toMonoidHomomorphism :: Monoid b
                     => (a -> b) -> List a -> b
toMonoidHomomorphism _ Nil         = mempty
toMonoidHomomorphism f (Cons a as) = f a `mappend` toMonoidHomomorphism f as

toMonadHomomorphism :: Monad m
                    => (forall x. f x -> m x)
                    -> Free f a -> m a
toMonadHomomorphism _ (Pure a)     = return a
toMonadHomomorphism f (Deep fFree) = f fFree >>= toMonadHomomorphism f


data Free f a = Pure a | Deep (f (Free f a))






















































































class Default a where
  def :: a


data List a = Nil | Cons a (List a)


instance Functor f => Functor (Free f) where
  fmap f (Pure a)     = Pure (f a)
  fmap f (Deep fFree) = Deep (fmap (fmap f) fFree)


main :: IO ()
main = putStrLn "typechecks."
