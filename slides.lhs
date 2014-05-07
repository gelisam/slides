a toy imperative language
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
> -- >>> interpret empty closed_ex
> -- 15
> -- 17
> interpret :: forall a. (a -> Int) -> Term a -> IO ()
> interpret e (Print x) = print (eval e x)
> interpret e (Seq x y) = interpret e x >> interpret e y
> interpret e (Let {- B () -} x body) = interpret e' body'
>   where
>     value = eval e x
>     
>     -- data Var b a = B b | F a
>     body' :: Term (Var () a)
>     body' = fromScope body
>     
>     e' :: Var () a -> Int
>     e' (B ())   = value
>     e' (F v)    = e v

> -- |
> -- >>> eval empty (Lit 2 `Add` Lit 5)
> -- 7
> eval :: (a -> Int) -> Exp a -> Int
> eval e (Lit i) = i
> eval e (Add x y) = eval e x + eval e y
> eval e (Mul x y) = eval e x * eval e y
> eval e (Var var) = e var

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
