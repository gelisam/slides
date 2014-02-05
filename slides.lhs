Type-level natural
---

> {-# LANGUAGE GADTs, KindSignatures #-}
> {-# LANGUAGE DataKinds, TypeOperators #-}
> import GHC.TypeLits

> data List (a :: *) (n :: Nat) where
>   Nil :: List a 0
>   Cons :: a -> List a   -> List a









> main = putStrLn "typechecks"
