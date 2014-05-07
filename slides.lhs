a function as the environment
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

> -- |
> -- >>> eval (const Nothing) ex
> -- 17
> eval :: (String -> Maybe Int) -> Exp -> Int
> eval e (Lit i) = i
> eval e (Add x y) = eval e x + eval e y
> eval e (Mul x y) = eval e x * eval e y
> eval e (Let var x body) = eval e' body
>   where
>     value = eval e x
>     e' v | v == var  = Just value
>     e' v | otherwise = e v
> eval e (Var var) = case e var of
>                      Just x -> x
>                      Nothing -> error "variable out of scope"

























> main = putStrLn "typechecks."
