{-# LANGUAGE InstanceSigs, RankNTypes #-}
import Control.Comonad



instance Comonad G where
  extract :: G a -> a
  extract (G x1) = x1                                                                                                  ; duplicate = G




-- type Getter s a = s -> a
-- 
-- (.) :: Getter u a -> Getter s u -> Getter s a

eeextract = extract . extract . extract :: FGH a -> a

























































data F a = F a
data G a = G a
data H a = H a

type FGH a = F (G (H a))
type  GH a =    G (H a)

instance Functor F where
  fmap f (F x) = F (f x)

instance Functor G where
  fmap f (G x) = G (f x)

instance Functor H where
  fmap f (H x) = H (f x)

instance Comonad F where
  extract (F x) = x
  duplicate = F

instance Comonad H where
  extract (H x) = x
  duplicate = H

main :: IO ()
main = putStrLn "done."
