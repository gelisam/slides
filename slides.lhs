a sample expression
===

> data Exp
>   = Lit Int
>   | Add Exp Exp
>   | Mul Exp Exp

> -- 2 + (3 * 5)
> ex :: Exp
> ex = Lit 2 `Add` (Lit 3 `Mul` Lit 5)










































> main = putStrLn "typechecks."
