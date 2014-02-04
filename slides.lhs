Type-level natural
---

> {-# LANGUAGE DataKinds, TypeOperators, GADTs #-}
> import Prelude hiding (reverse)
> import GHC.TypeLits
> import List





> reverse :: List a n -> List a n
> reverse Nil = Nil
> reverse (Cons x xs) = snoc (reverse xs) x



> main = print $ preciseHead foo




