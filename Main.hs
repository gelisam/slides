{-# LANGUAGE GADTs #-}
import Prelude hiding (Monoid(..))




class Monoid a where
    mempty  :: a
    mappend :: a -> a -> a

data Circle = Circle
  { center :: (Double,Double)
  , radius :: Double
  }

data Circle' = ...

instance Monoid Circle' where
    mempty  = ...
    mappend = ...

emptyCircle :: Circle'
emptyCircle = mempty














































































































main :: IO ()
main = putStrLn "typechecks."
