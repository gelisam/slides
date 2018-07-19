module Slide where
import Prelude hiding (lookup, foldr)
import Test.DocTest


-- |
-- >>> lookup "bar" [("foo",1), ("bar",2), ("baz",3)]
-- Just 2
-- >>> lookup "lol" [("foo",1), ("bar",2), ("baz",3)]
-- Nothing
lookup :: forall k a. Eq k
       => k -> [(k,a)] -> Maybe a
lookup key = foldr cons Nothing where





  cons :: (k,a) -> Maybe a -> Maybe a
  cons (k,a) keepLooking = if k == key then Just a
                                       else keepLooking


foldr :: (a -> r -> r) -> r -> [a] -> r
foldr cons nil = go where
  go []     = nil
  go (a:as) = a `cons` go as



















































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
