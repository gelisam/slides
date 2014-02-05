Nullary Type Classes
---

> {-# LANGUAGE NullaryTypeClasses #-}
> import Unsafe.Coerce



> foo ::              Double -> Double -> Int
> foo x y = coerce x + coerce y

> main ::              IO ()
> main = print (foo 3.0 4.0)


> coerce :: a -> b
> coerce = unsafeCoerce








