{-# LANGUAGE RankNTypes #-}
module Main where
import Test.DocTest




data These a b = This a | That b | These a b






































































































main :: IO ()
main = doctest ["src/Main.hs"]
