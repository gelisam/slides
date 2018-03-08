module Main where
import Test.DocTest

import Data.Complex


-- |
-- >>> showInt 42
-- "42"
showInt :: Int -> String
showInt = show

-- |
-- >>> liftedShowInt (42.0 :: Double)
-- ...undefined
-- ...
-- >>> liftedShowInt (42.0 :+ 0.0 :: Complex Double)
-- ...undefined
-- ...
liftedShowInt :: Num a => a -> String
liftedShowInt = showInt    -- Int -> String
              . undefined  -- a   -> Int


main :: IO ()
main = doctest ["src/Main.hs"]
