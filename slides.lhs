instantiate1 doesn't work
===

> {-# LANGUAGE DeriveFunctor, DeriveFoldable, DeriveTraversable, ScopedTypeVariables #-}
> import Bound.Scope.Simple
> import Bound.Term
> import Bound.Var
> import Control.Applicative (Applicative(..), (<$>))
> import Control.Monad
> import Data.Foldable
> import Data.Traversable

> data Term a
>   = Print (Exp a)
>   | Seq (Term a) (Term a)
>   | Let {- B () = -} (Exp a) {- in -} (Scope () Term a)
>   deriving (Functor, Foldable, Traversable)

> data Exp a
>   = Lit Int
>   | Add (Exp a) (Exp a)
>   | Mul (Exp a) (Exp a)
>   | Var a
>   deriving (Functor, Foldable, Traversable)

> -- let x = (3 * 5)
> --  in print x
> --     print (2 + x)
> ex :: Term String
> ex = let_ "x" (Lit 3 `Mul` Lit 5)
>             $ Print (Var "x")
>         `Seq` Print (Lit 2 `Add` Var "x")

> let_ :: Eq a => a -> Exp a -> Term a -> Term a
> let_ var x body = Let x (abstract1 var body)

> closed_ex :: Term Void
> Just closed_ex = closed ex

> -- |
> -- >>> interpret closed_ex
> -- 15
> -- 17
> interpret :: Term Void -> IO ()
> interpret (Print x) = print (eval x)
> interpret (Seq x y) = interpret x >> interpret y
> interpret (Let {- B () -} x body) = interpret body'
>   where
>     value = eval x
>     
>     -- (Lit value) has type (Exp Void), expected (Term Void)
>     body' :: Term Void
>     body' = instantiate1 (Lit value) body
>     
>     -- instantiate1 :: Monad f => f a -> Scope () f a -> f a
>     
>     

> -- |
> -- >>> eval (Lit 2 `Add` Lit 5)
> -- 7
> eval :: Exp Void -> Int
> eval (Lit i) = i
> eval (Add x y) = eval x + eval y
> eval (Mul x y) = eval x * eval y
> eval (Var var) = empty var

> instance Monad Exp where
>   return = Var
>   Lit i   >>= f = Lit i
>   Add x y >>= f = Add (x >>= f) (y >>= f)
>   Mul x y >>= f = Mul (x >>= f) (y >>= f)
>   Var v   >>= f = f v
> instance Applicative Exp where
>   pure = return
>   (<*>) = ap

























> data Void

> empty :: Void -> a
> empty v = v `seq` error "never happens."

> main = putStrLn "typechecks."
