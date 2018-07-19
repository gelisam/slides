module Slide where
import Test.DocTest
import Control.Comonad
import Data.Functor.Identity

fold   :: forall s f r. Functor f
       => (s -> f s) -> (f     r  -> r) -> s -> r

zygo   :: forall s f i r. Functor f
       =>               (f     i  -> i)
       -> (s -> f s) -> (f (i, r) -> r) -> s -> r

-- m ~ Identity
ghylo :: (Functor f, Comonad w)
      => (s -> f           s )
      -> (forall x.           f x  -> f           x )
      -> (forall x. f (w x) -> w (f x))
      -> (f (w r) -> r)
      -> s -> r















































































fold = undefined
zygo = undefined

ghylo = ghylo

main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
