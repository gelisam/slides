module Main where
import Test.DocTest

import Data.Complex


showInt :: Int -> String
showInt = show


class ToInt a where
  toInt :: a -> Int

liftedShowInt :: ToInt a => a -> String
liftedShowInt = showInt . toInt


-- |
-- >>> liftedShowInt (42 :: Int)
-- "42"
instance ToInt Int where
  toInt = id

-- |
-- >>> liftedShowInt (42.2 :: Double)
-- "42"
instance ToInt Double where
  toInt = round

-- |
-- >>> liftedShowInt (42.0 :+ 3.0 :: Complex Double)
-- "42"
instance ToInt a => ToInt (Complex a) where
  toInt = toInt . realPart


main :: IO ()
main = doctest ["src/Main.hs"]
