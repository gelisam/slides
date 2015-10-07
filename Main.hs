{-# LANGUAGE GADTs #-}
import Prelude hiding (Monoid(..))




class Monoid a where
    mempty  :: a
    mappend :: a -> a -> a

data Circle = Circle
  { center :: (Double,Double)
  , radius :: Double
  }

data FreeMonoid a = ...

instance Monoid (FreeMonoid a) where
    mempty  = ...
    mappend = ...

emptyCircle :: FreeMonoid Circle
emptyCircle = mempty














































































































main :: IO ()
main = putStrLn "typechecks."
