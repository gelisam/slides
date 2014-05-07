adding let expressions.
===

> data Exp
>   = Lit Int
>   | Add Exp Exp
>   | Mul Exp Exp
>   | Let String {- = -} Exp {- in -} Exp
>   | Var String

> -- let x = (3 * 5)
> --  in 2 + x
> ex :: Exp
> ex = Let "x" (Lit 3 `Mul` Lit 5)
>              (Lit 2 `Add` Var "x")























> main = putStrLn "typechecks."
