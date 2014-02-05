> {-# LANGUAGE GADTs, KindSignatures #-}
> {-# LANGUAGE DataKinds, TypeOperators #-}
> module List where
> import GHC.TypeLits

> data List (a :: *) (n :: Nat) where
>   Nil :: List a 0
>   Cons :: a -> List a n -> List a (n + 1)

> foo :: List Int 3
> foo = 1 `Cons` (2 `Cons` (3 `Cons` Nil))

> preciseHead :: List a (n + 1) -> a
> preciseHead Nil = error "cannot happen"
> preciseHead (Cons x _) = x
