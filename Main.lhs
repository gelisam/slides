> {-# LANGUAGE GADTs #-}
> import Prelude hiding ((!!))


  Safe (!!):

> data Nat where
>   Z :: Nat
>   S :: Nat -> Nat





> data List a           where
>   Nil  :: List a
>   Cons :: a -> List a  -> List a

> (!!) :: [a]     -> Int   -> a
> Nil         !! _        = ?
> (Cons x _ ) !! Z        = x
> (Cons _ xs) !! (S i)    = xs !! i




































































> main :: IO ()
> main = putStrLn "typechecks."
