{-# LANGUAGE InstanceSigs, RankNTypes #-}
import Prelude hiding (Foldable, toList)
import Control.Monad


instance Foldable G where
  toList :: G a -> [a]
  toList (G x1 x2) = [x1, x2]






-- (>=>) :: Monad m => (a -> m b) -> (b -> m c) -> (a -> m c)

tttoList = toList >=> toList >=> toList :: FGH a -> [a]

























































data F a = F a a
data G a = G a a
data H a = H a a

type FGH a = F (G (H a))
type  GH a =    G (H a)

class Foldable f where
  toList :: f a -> [a]

instance Foldable F where
  toList :: F a -> [a]
  toList (F x1 x2) = [x1, x2]

instance Foldable H where
  toList :: H a -> [a]
  toList (H x1 x2) = [x1, x2]

main :: IO ()
main = putStrLn "done."
