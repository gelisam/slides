look ma, no environment!
===

> {-# LANGUAGE DeriveFunctor, DeriveFoldable, DeriveTraversable, ScopedTypeVariables #-}
> import Bound
> import Control.Applicative (Applicative(..), (<$>))
> import Control.Monad
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

> let_ :: Eq a => a -> Exp a -> Exp a -> Exp a
> let_ var x body = Let x (abstract1 var body)

> closed_ex :: Exp Void
> Just closed_ex = closed ex

> -- |
> -- >>> eval closed_ex
> -- 17
> eval :: Exp Void -> Int
> eval (Lit i) = i
> eval (Add x y) = eval x + eval y
> eval (Mul x y) = eval x * eval y
> eval (Let {- B () -} x body) = eval body'
>   where
>     value = eval x
>     
>     
>     body' :: Exp Void
>     body' = instantiate1 (Lit value) body
>     
>     
>     
>     
> eval (Var var) = empty var

> instance Monad Exp where
>   return = Var
>   Lit i      >>= f = Lit i
>   Add x y    >>= f = Add (x >>= f) (y >>= f)
>   Mul x y    >>= f = Mul (x >>= f) (y >>= f)
>   Let x body >>= f = Let (x >>= f) (body >>>= f)
>   Var v      >>= f = f v
> instance Applicative Exp where
>   pure = return
>   (<*>) = ap




















> data Void

> empty :: Void -> a
> empty v = v `seq` error "never happens."

> main = putStrLn "typechecks."
