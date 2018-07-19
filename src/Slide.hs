module Slide where
import Test.DocTest
import Control.Comonad


fold   :: forall s f r. Functor f
       => (s -> f s) -> (f     r  -> r) -> s -> r

zygo   :: forall s f i r. Functor f
       =>               (f     i  -> i)
       -> (s -> f s) -> (f (i, r) -> r) -> s -> r


ghylo :: (Monad m, Functor f, Comonad w)
      => (s -> f (m s))
      -> (forall x. m (f x) -> f (m x))
      -> (forall x. f (w x) -> w (f x))
      -> (f (w r) -> r)
      -> s -> r















































































fold = undefined
zygo = undefined

ghylo = ghylo

main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
