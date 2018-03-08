module Main where
import Test.DocTest

import Data.Complex


-- |
-- >>> showInt 42
-- "42"
showInt :: Int -> String
showInt = show


main :: IO ()
main = doctest ["src/Main.hs"]
