module Slide where
import Test.DocTest

fold   :: forall s f r. Functor f
       => (s -> f s) -> (f     r  -> r) -> s -> r

unfold :: forall s f r. Functor f
       => (s -> f s) -> (f     r  -> r) -> s -> r

hylo   :: forall s f r. Functor f
       => (s -> f s) -> (f     r  -> r) -> s -> r

para   :: forall s f r. Functor f
       => (s -> f s) -> (f (s, r) -> r) -> s -> r



























































































fold   = undefined
para   = undefined
unfold = undefined
hylo   = undefined
zygo   = undefined


main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
