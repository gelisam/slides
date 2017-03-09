{-# LANGUAGE RankNTypes #-}

type Func      a   s   =                                    a  ->         s
type Setter'   a   s   =                            (a ->   a) -> (s ->   s)
type Setter    a b s t =                            (a ->   b) -> (s ->   t)
type Fold      a   s   = forall m. Monoid m      => (a ->   m) -> (s ->   m)
type Getter    a   s   = forall e.                  (a ->   e) -> (s ->   e)
type Traversal a b s t = forall f. Applicative f => (a -> f b) -> (s -> f t)
type Lens      a b s t = forall f. Functor f     => (a -> f b) -> (s -> f t)

(.) :: Lens u v s t -> Lens a b u v -> Lens a b s t















































data Const m a = Const m

(.) f g x = f (g x)


main :: IO ()
main = putStrLn "done."
