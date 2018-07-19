module Slide where
import Prelude hiding (map, (++), foldr)
import Test.DocTest


-- |
-- >>> map (+10) [1,2,3]
-- [11,12,13]
map :: forall a b. (a -> b) -> [a] -> [b]
map f = foldr cons [] where
  cons :: a -> [b] -> [b]
  cons a bs = f a : bs

-- |
-- >>> "foo" ++ "bar"
-- "foobar"
(++) :: [a] -> [a] -> [a]
[]     ++ ys = ys
(x:xs) ++ ys = x : (xs ++ ys)




foldr :: (a -> r -> r) -> r -> [a] -> r
foldr cons nil = go where
  go []     = nil
  go (a:as) = a `cons` go as



















































































main :: IO ()
main = doctest ["-XDeriveFunctor", "-XGADTs", "-XKindSignatures", "-XLambdaCase", "-XMultiParamTypeClasses", "-XRankNTypes", "-XScopedTypeVariables", "src/Slide.hs"]
