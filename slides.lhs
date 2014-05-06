a simple evaluator
===

> data Exp
>   = Lit Int
>   | Add Exp Exp
>   | Mul Exp Exp

> -- 2 + (3 * 5)
> ex :: Exp
> ex = Lit 2 `Add` (Lit 3 `Mul` Lit 5)

> -- |
> -- >>> eval ex
> -- 17
> eval :: Exp -> Int
> eval (Lit i) = i
> eval (Add x y) = eval x + eval y
> eval (Mul x y) = eval x * eval y


































> main = putStrLn "typechecks."
