{-# LANGUAGE RankNTypes #-}


type Setter' s   a   = (a -> a) -> (s -> s)
type Setter  s t a b = (a -> b) -> (s -> t)

-- fmap :: Functor f => (a -> a) -> (f a -> f a)
-- fmap :: Functor f => (a -> b) -> (f a -> f b)

-- fmap :: Functor f => Setter' (f a)       a
-- fmap :: Functor f => Setter  (f a) (f b) a b






























































main :: IO ()
main = putStrLn "done."
