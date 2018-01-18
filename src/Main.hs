{-# LANGUAGE InstanceSigs, RankNTypes #-}


type Traversal s t a b = forall f. Applicative f => (a -> f b) -> (s -> f t)

instance Traversable G where
  traverse :: Applicative f => (a -> f b) -> G a -> f (G b)
  traverse f (G x1 x2) = G <$> f x1 <*> f x2

-- FGH a -> f (FGH b)
--        |
--        |   GH a -> f (GH b)
--        |         |
--        |         |   H a -> f (H b)
--        |         |        |
--        v         v        v
-- tttrav = traverse.traverse.traverse :: (a -> f b) -> (FGH a -> f (FGH b))
-- tttrav = traverse.traverse.traverse :: Traversal (FGH a) (FGH b) a b
--        ^         ^        ^         ^
--        |         |        |         |
--      FGH a      GH a      H a       a  ----.
--   f (FGH b)  f (GH b)  f (H b)    f b  <---'

























































data F a
data G a = G a a
data H a

type FGH a = F (G (H a))
type  GH a =    G (H a)

instance Functor G where
  fmap f (G x1 x2) = G (f x1) (f x2)

instance Foldable G where
  foldMap f (G x1 x2) = f x1 `mappend` f x2

main :: IO ()
main = putStrLn "done."
