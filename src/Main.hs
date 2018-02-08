{-# LANGUAGE RankNTypes #-}
module Main where
import Test.DocTest

import Control.Lens


-- |
-- >>> toListOf (each . _Left) [Left "foo", Right "bar", Left "baz"]
-- ["foo","baz"]
-- >>> view (_1 . re _Left) ("foo","bar")
-- Left "foo"
-- >>> view (_1 . to Left) ("foo","bar")
-- Left "foo"
re' :: Prism' s a -> Getter a s
re' = re






































































































main :: IO ()
main = doctest ["src/Main.hs"]
