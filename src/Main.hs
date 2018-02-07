{-# LANGUAGE GADTs, RankNTypes, ScopedTypeVariables #-}

type Setter    s t a b =                            (a ->   b) -> (s ->   t)
type Fold      s   a   = forall m. Monoid m      => (a ->   m) -> (s ->   m)
type Getter    s   a   = forall e.                  (a ->   e) -> (s ->   e)
type Traversal s t a b = forall f. Applicative f => (a -> f b) -> (s -> f t)
type Lens      s t a b = forall f. Functor f     => (a -> f b) -> (s -> f t)

toSetter :: forall s t a b
          . Traversal s t a b -> Setter s t a b
toSetter traversal f s = runIdentity t'
  where
    f' :: a -> Identity b
    f' = Identity . f

    t' :: Identity t
    t' = traversal f' s














































data Const m a = Const m
data Identity a = Identity { runIdentity :: a }

instance Functor Identity where
  fmap f (Identity x) = Identity (f x)

instance Applicative Identity where
  pure x = Identity x
  Identity f <*> Identity x = Identity (f x)


main :: IO ()
main = putStrLn "done."
