module Slide where
import Test.DocTest
import Control.Comonad
import Data.Functor.Identity

fold   :: forall s f r. Functor f
       => (s -> f s) -> (f     r  -> r) -> s -> r

zygo   :: forall s f i r. Functor f
       =>               (f     i  -> i)
       -> (s -> f s) -> (f (i, r) -> r) -> s -> r

-- w ~ EnvT i (EnvT j Identity)
gcata :: Functor f
      => (s -> f s)
      -> (forall x. f    (i, j, x) ->    (i, j, f x))
      -> (f    (i, j, r) -> r)
      -> s -> r

data EnvT i f a = EnvT i (f a)












































































fold = undefined
zygo = undefined

gcata = gcata

main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
