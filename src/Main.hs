{-# LANGUAGE InstanceSigs, RankNTypes #-}


type Lens s t a b = forall f. Functor f => (a -> f b) -> (s -> f t)

instance Singleton G where
  runOnce :: Functor f => (a -> f b) -> G a -> f (G b)
  runOnce f (G x1) = G <$> f x1

--    FGH a -> f (FGH b)
--           |
--           |  GH a -> f (GH b)
--           |        |
--           |        |  H a -> f (H b)
--           |        |       |
--           v        v       v
-- rrrunOnce = runOnce.runOnce.runOnce :: (a -> f b) -> (FGH a -> f (FGH b))
-- rrrunOnce = runOnce.runOnce.runOnce :: Lens (FGH a) (FGH b) a b
--           ^        ^       ^        ^
--           |        |       |        |
--         FGH a     GH a     H a      a  ----.
--      f (FGH b) f (GH b) f (H b)   f b  <---'

























































data F a
data G a = G a
data H a

type FGH a = F (G (H a))
type  GH a =    G (H a)

class Traversable t => Singleton t where
  runOnce :: Functor f => (a -> f b) -> t a -> f (t b)

instance Functor G where
  fmap f (G x1) = G (f x1)

instance Foldable G where
  foldMap f (G x1) = f x1

instance Traversable G where
  traverse :: Applicative f => (a -> f b) -> G a -> f (G b)
  traverse f (G x1) = G <$> f x1

main :: IO ()
main = putStrLn "done."
