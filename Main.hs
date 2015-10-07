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


instance (Monoid a, Monoid b) => Monoid (a,b) where
    mempty = (mempty, mempty)
    mappend (x1,y1) (x2,y2) = (mappend x1 x2, mappend y1 y2)












































































































main :: IO ()
main = putStrLn "typechecks."
