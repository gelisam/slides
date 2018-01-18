{-# LANGUAGE RankNTypes #-}

---- Back      s   a   =                                    a  ->         s
---- Setter'   s   a   =                            (a ->   a) -> (s ->   s)
---- Setter    s t a b =                            (a ->   b) -> (s ->   t)
---- Fold      s   a   = forall m. Monoid m      => (a ->   m) -> (s ->   m)
---- Getter    s   a   = forall e.                  (a ->   e) -> (s ->   e)
type Traversal s t a b = forall f. Applicative f => (a -> f b) -> (s -> f t)
type Lens      s t a b = forall f. Functor f     => (a -> f b) -> (s -> f t)

















































data Const m a = Const m

main :: IO ()
main = putStrLn "done."
