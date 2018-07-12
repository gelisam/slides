module Slide where
import Prelude hiding (lookup)
import Test.DocTest


-- |
-- >>> lookup "bar" [("foo",1), ("bar",2), ("baz",3)]
-- Just 2
-- >>> lookup "lol" [("foo",1), ("bar",2), ("baz",3)]
-- Nothing
lookup :: forall k a. Eq k
       => k -> [(k,a)] -> Maybe a
lookup key = go where
  go :: [(k,a)] -> Maybe a
  go []           = Nothing
  go ((k,a):rest) = if k == key then Just a
                                else go rest

  cons :: (k,a) -> Maybe a -> Maybe a
  cons (k,a) keepLooking = if k == key then Just a
                                       else keepLooking


fold :: (a -> a -> a) -> a -> [a] -> a
fold cons nil = go where
  go []     = nil
  go (a:as) = a `cons` go as



















































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
