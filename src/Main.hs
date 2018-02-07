{-# LANGUAGE RankNTypes #-}


type Setter'   s   a   =                            (a ->   a) -> (s ->   s)
type Setter    s t a b =                            (a ->   b) -> (s ->   t)
type Fold      s   a   = forall m. Monoid m      => (a ->   m) -> (s ->   m)
type Getter    s   a   = forall e.                  (a ->   e) -> (s ->   e)
type Traversal s t a b = forall f. Applicative f => (a -> f b) -> (s -> f t)
type Lens      s t a b = forall f. Functor f     => (a -> f b) -> (s -> f t)

















































data Const m a = Const m


main :: IO ()
main = putStrLn "done."
