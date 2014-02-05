Type-level natural
---

> {-# LANGUAGE GADTs, KindSignatures #-}
> {-# LANGUAGE DataKinds, TypeOperators #-}
> import GHC.TypeLits

> data List (a :: *) where
>   Nil :: List a
>   Cons :: a -> List a   -> List a









> main = putStrLn "typechecks"
