{-# LANGUAGE GADTs #-}
import Prelude hiding (Monoid(..))




class Monoid a where
    mempty  :: a
    mappend :: a -> a -> a

data Circle = Circle
  { center :: (Double,Double)
  , radius :: Double
  }


















































































































main :: IO ()
main = putStrLn "typechecks."
