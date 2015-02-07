> {-# LANGUAGE GADTs #-}
> import Prelude hiding ((!!))

  Unsafe (!!):

> data Nat where
>   Z :: Nat
>   S :: Nat -> Nat

> data List a where
>   Nil  :: List a
>   Cons :: a -> List a -> List a

> (!!) :: List a -> Nat -> a
> Nil         !! _     = error "index too large"
> (Cons x _ ) !! Z     = x
> (Cons _ xs) !! (S i) = xs !! i




































































> main :: IO ()
> main = putStrLn "typechecks."
