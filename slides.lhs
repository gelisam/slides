Nullary Type Classes
---

> {-# LANGUAGE NullaryTypeClasses #-}
> import Unsafe.Coerce
> class Coercible where
>   coerce :: a -> b

> foo ::              Double -> Double -> Int
> foo x y = coerce x + coerce y

> main ::              IO ()
> main = print (foo 3.0 4.0)


> instance Coercible where
>   coerce = unsafeCoerce








