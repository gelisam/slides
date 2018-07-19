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

zygo   :: forall s f i r. Functor f
       =>               (f     i  -> i)
       -> (s -> f s) -> (f (i, r) -> r) -> s -> r

zygo2  :: forall s f i j r. Functor f
       =>               (f        i  -> i)
       ->               (f        j  -> j)
       -> (s -> f s) -> (f (i, j, r) -> r) -> s -> r

zygo3  :: forall s f i j k r. Functor f
       =>               (f           i  -> i)
       ->               (f           j  -> j)
       ->               (f           k  -> k)
       -> (s -> f s) -> (f (i, j, k, r) -> r) -> s -> r























































































fold   = undefined
para   = undefined
unfold = undefined
hylo   = undefined
zygo   = undefined
zygo2  = undefined
zygo3  = undefined


main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
