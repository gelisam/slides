demonstrating closed
===

> {-# LANGUAGE DeriveFunctor, DeriveFoldable, DeriveTraversable, ScopedTypeVariables #-}
> import Bound.Scope.Simple
> import Bound.Term
> import Bound.Var
> import Data.Foldable
> import Data.Traversable

> data Exp a
>   = Lit Int
>   | Add (Exp a) (Exp a)
>   | Mul (Exp a) (Exp a)
>   | Let {-    B () = -} (Exp a) {- in -} (Scope () Exp a)
>   | Var a
>   deriving (Functor, Foldable, Traversable)

> -- let x = (3 * 5)
> --  in 2 + x
> ex :: Exp String
> ex = let_ "x" (Lit 3 `Mul` Lit 5)
>               (Lit 2 `Add` Var "x")




> closed_ex :: Exp Void
> Just closed_ex = closed ex

> -- |
> -- >>> eval empty closed_ex
> -- 17
> eval :: forall a. (a -> Int) -> Exp a -> Int
> eval e (Lit i) = i
> eval e (Add x y) = eval e x + eval e y
> eval e (Mul x y) = eval e x * eval e y
> eval e (Let {-    B () -} x body) = eval e' body'
>   where
>     value = eval e x
>     
>     -- data Var b a = B b | F a
>     body' :: Exp (Var () a)
>     body' = fromScope body
>     
>     e' :: Var () a -> Int
>     e' (B ())   = value
>     e' (F v)    = e v
> eval e (Var var) = e var




























> data Void

> empty :: Void -> a
> empty v = v `seq` error "never happens."

> main = putStrLn "typechecks."
