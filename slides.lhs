Nullary Type Classes
---

> {-# LANGUAGE NullaryTypeClasses #-}

> class Coercible where
>   coerce :: a -> b

> foo :: Coercible => Double -> Double -> Int
> foo x y = coerce x + coerce y












> main = putStrLn "typechecks"
