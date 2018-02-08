{-# LANGUAGE RankNTypes #-}
module Main where
import Test.DocTest

import Control.Lens


-- |
-- >>> toListOf (each . _Left) [Left "foo", Right "bar", Left "baz"]
-- ["foo","baz"]
re' :: Prism' s a -> Getter a s
re' = re






































































































main :: IO ()
main = doctest ["src/Main.hs"]
