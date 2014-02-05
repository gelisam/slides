Nullary Type Classes
---

> {-# LANGUAGE NullaryTypeClasses #-}

> class Coercible where
>   coerce :: a -> b

> foo :: Coercible => Double -> Double -> Int
> foo x y = coerce x + coerce y

> main :: IO ()
> main = print (foo 3.0 4.0)











