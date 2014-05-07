(indenting to match the next slide)
===

> {-# LANGUAGE ScopedTypeVariables #-}



> data Exp a
>   = Lit Int
>   | Add (Exp a) (Exp a)
>   | Mul (Exp a) (Exp a)
>   | Let {- Left () = -} (Exp a) {- in -} (Exp (Either () a))
>   | Var a

> -- let x = (3 * 5)
> --  in 2 + x
> ex :: Exp Void
> ex = Let (Lit 3 `Mul` Lit 5)
>          (Lit 2 `Add` Var (Left ()))


> -- |
> -- >>> eval empty ex
> -- 17
> eval :: forall a. (a -> Int) -> Exp a -> Int
> eval e (Lit i) = i
> eval e (Add x y) = eval e x + eval e y
> eval e (Mul x y) = eval e x * eval e y
> eval e (Let {- Left () -} x body) = eval e' body
>   where
>     value = eval e x
>     
>     
>     
>     
>     
>     e' :: Either () a -> Int
>     e' (Left ()) = value
>     e' (Right v) = e v
> eval e (Var var) = e var























> data Void

> empty :: Void -> a
> empty v = v `seq` error "never happens."

> main = putStrLn "typechecks."
