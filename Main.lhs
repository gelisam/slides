> {-# LANGUAGE DataKinds, GADTs, KindSignatures #-}
> import Prelude hiding ((!!))
> import GHC.Conc

  Safe (!!):

> data Nat where
>   Z :: Nat
>   S :: Nat -> Nat

> data Fin (n :: Nat) where
>   FinZ :: Fin (S n)
>   FinS :: Fin n -> Fin (S n)

> data Vec a (n :: Nat) where
>   Nil  :: Vec a Z
>   Cons :: a -> Vec a n -> Vec a (S n)

> (!!) :: Vec a n -> Fin n -> a
> Nil         !! i        = i `pseq` error "never happens"
> (Cons x _ ) !! FinZ     = x
> (Cons _ xs) !! (FinS i) = xs !! i



































































> main :: IO ()
> main = putStrLn "typechecks."
