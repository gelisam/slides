module Main where
import Test.DocTest

import Text.Read
import Data.Complex

-- |
-- >>> parseInt "42"
-- Just 42
parseInt :: String -> Maybe Int
parseInt = readMaybe

-- |
-- >>> liftedParseInt "42" :: Maybe Double
-- Just 42.0
-- >>> liftedParseInt "42" :: Maybe (Complex Double)
-- Just (42.0 :+ 0.0)
liftedParseInt :: Num a => String -> Maybe a
liftedParseInt = fmap fromIntegral  -- Maybe Int -> Maybe a
               . parseInt           -- String    -> Maybe Int


main :: IO ()
main = doctest ["src/Main.hs"]
