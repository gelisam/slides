module Main where
import Test.DocTest

import Text.Read


-- |
-- >>> parseInt "42"
-- Just 42
parseInt :: String -> Maybe Int
parseInt = readMaybe


main :: IO ()
main = doctest ["src/Main.hs"]
