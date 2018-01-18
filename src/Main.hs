{-# LANGUAGE InstanceSigs, RankNTypes #-}
import Data.Monoid

type Fold s a = forall m. Monoid m => (a -> m) -> (s -> m)

instance Foldable G where
  foldMap :: Monoid m => (a -> m) -> G a -> m
  foldMap f (G x1 x2) = f x1 <> f x2

--     FGH a -> m
--           |
--           |    GH a -> m
--           |         |
--           |         |     H a -> m
--           |         |         |
--           v         v         v
-- fffoldMap = foldMap . foldMap . foldMap :: (a -> m) -> (FGH a -> m)
-- fffoldMap = foldMap . foldMap . foldMap :: Fold (FGH a) a
--           ^         ^         ^         ^
--           |         |         |         |
--         FGH a      GH a      H a        a  ----.
--             m         m        m        m  <---'

























































data F a
data G a = G a a
data H a

type FGH a = F (G (H a))
type  GH a =    G (H a)

main :: IO ()
main = putStrLn "done."
