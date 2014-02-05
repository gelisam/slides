Type-level natural
---

> {-# LANGUAGE GADTs, KindSignatures #-}
> {-# LANGUAGE DataKinds, TypeOperators #-}
> import GHC.TypeLits

> data List (a :: *) (n :: Nat) where
>   Nil :: List a 0
>   Cons :: a -> List a n -> List a (n + 1)

> foo :: List Int 3
> foo = 1 `Cons` (2 `Cons` (3 `Cons` Nil))

ghc 7.6:
Couldn't match type (0 + (1 + (1 + 1))) with 3



> main = putStrLn "typechecks"
