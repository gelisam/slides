Kmett's solution
===

> {-# LANGUAGE DeriveFunctor, DeriveFoldable, DeriveTraversable, RankNTypes, ScopedTypeVariables #-}
> import Bound.Scope.Simple
> import Bound.Term
> import Bound.Var
> import Control.Applicative (Applicative(..), (<$>))
> import Control.Monad
> import Data.Foldable
> import Data.Traversable

> data Term e a
>   = Print (e a)
>   | Seq (Term e a) (Term e a)
>   | Let {- B () = -} (e a) {- in -} (Term (Scope () e) a)
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
> ex :: Term Exp String
> ex = let_ "x" (Lit 3 `Mul` Lit 5)
>             $ Print (Var "x")
>         `Seq` Print (Lit 2 `Add` Var "x")

> let_ :: (Functor e, Eq a) => a -> e a -> Term e a -> Term e a
> let_ var x body = Let x (myAbstract1 var body)

> closed_ex :: Term Exp Void
> Just closed_ex = myClosed ex

> -- |
> -- >>> interpret closed_ex
> -- 15
> -- 17
> interpret :: Term Exp Void -> IO ()
> interpret (Print x) = print (eval x)
> interpret (Seq x y) = interpret x >> interpret y
> interpret (Let {- B () -} x body) = interpret body'
>   where
>     value = eval x
>     
>     
>     body' :: Term Exp Void
>     body' = myInstantiate1 (Lit value) body
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

> -- closed :: Traversable e => e a -> Maybe (e b)
> myClosed :: Traversable e => Term e a -> Maybe (Term e Void)
> myClosed (Print x) = Print <$> closed x
> myClosed (Seq x y) = Seq <$> myClosed x
>                          <*> myClosed y
> myClosed (Let x body) = Let <$> closed x
>                             <*> myClosed body

> -- abstract1 :: (Functor e, Eq a)
> --           => a -> e a -> Scope () e a
> myAbstract1 :: forall e a. (Functor e, Eq a)
>             => a -> Term e a -> Term (Scope () e) a
> myAbstract1 var = hoist (abstract go)
>   where
>     go :: Var b a -> Maybe ()
>     go (F v) | var == v = Just ()
>     go _ = Nothing

> -- instantiate1 :: Monad e
> --              => e a -> Scope () e a -> e a
> myInstantiate1 :: forall e a. (Functor e, Monad e)
>                => e a -> Term (Scope () e) a -> Term e a
> myInstantiate1 e = hoist (instantiate (\() -> fmap F e))
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 

> hoist :: (Functor e, Functor f)
>       => (forall x. e (Var x a) -> f (Var x a))
>       -> Term e a -> Term f a
> hoist f (Print x) = Print (fmap (\(F x) -> x) $ f $ fmap F x)
> hoist f (Seq x1 x2) = Seq (hoist f x1)
>                           (hoist f x2)
> hoist f (Let x1 x2) = Let (fmap (\(F x) -> x) $ f $ fmap F x1)
>                           (hoist (doubleHoist f) x2)
> 
> doubleHoist :: (Functor e, Functor f)
>             => (forall x. e (Var x a) -> f (Var x a))
>             -> Scope () e (Var x a) -> Scope () f (Var x a)
> doubleHoist f = Scope . fmap assocR . f . fmap assocL . unscope
> 
> assocL :: Var a (Var b c) -> Var (Var a b) c
> assocL (B a) = B (B a)
> assocL (F (B b)) = B (F b)
> assocL (F (F c)) = F c
> 
> assocR :: Var (Var a b) c -> Var a (Var b c)
> assocR (B (B a)) = B a
> assocR (B (F b)) = F (B b)
> assocR (F c) = F (F c)



















> data Compose f g a = Compose { runCompose :: f (g a) }
>   deriving Functor

> data Void

> empty :: Void -> a
> empty v = v `seq` error "never happens."

> main = putStrLn "typechecks."
