module Slide where
import Test.DocTest



fold   :: forall s f r. Functor f
       => (s -> f s) -> (f     r  -> r) -> s -> r

zygo   :: forall s f i r. Functor f
       =>               (f     i  -> i)
       -> (s -> f s) -> (f (i, r) -> r) -> s -> r


gcata :: Functor f
      => (s -> f s)
      -> (r -> f z -> z)
      -> (f z -> r)
      -> s -> r















































































fold = undefined
zygo = undefined

gcata = gcata

main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
