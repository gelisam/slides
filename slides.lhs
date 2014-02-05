Type-level natural
---

> {-# LANGUAGE DataKinds, TypeOperators, GADTs #-}
> import Prelude hiding (reverse)
> import GHC.TypeLits
> import List

> snoc :: List a n -> a -> List a (n + 1)
> snoc Nil y         = Cons y Nil
> snoc (Cons x xs) y = Cons x (snoc xs y)

> reverse :: List a n -> List a n
> reverse Nil = Nil
> reverse (Cons x xs) = snoc (reverse xs) x

> defaultHead :: a -> List a n -> a
> defaultHead x xs = preciseHead (snoc xs x)


> main = do
>     print $ preciseHead foo
>     print $ defaultHead 0 $ reverse Nil


