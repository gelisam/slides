{-# LANGUAGE GADTs #-}
import Prelude hiding (Monoid(..))

-- x <> mempty = x
-- mempty <> y = y
-- (x <> y) <> z = x <> (y <> z)
class Monoid a where
    mempty  :: a
    mappend :: a -> a -> a

data MonoidAST a where
    Base    :: a -> MonoidAST a
    MEmpty  :: MonoidAST a
    MAppend :: MonoidAST a -> MonoidAST a -> MonoidAST a

-- mempty                      = []
-- 
-- x                           = [x]
-- 
-- x <> y                      = [x,y]
-- 
-- x <> (y <> z) =
-- (x <> y) <> z               = [x,y,z]
-- 
-- x <> (y <> (z <> t)) =
-- x <> ((y <> z) <> t) =
-- (x <> (y <> z)) <> t =
-- ((x <> y) <> z) <> t        = [x,y,z,t]
-- 
-- x <> (y <> (z <> (t <> u))) =
-- x <> (y <> ((z <> t) <> u)) =
-- x <> ((y <> (z <> t)) <> u) =
-- x <> (((y <> z) <> t) <> u) =
-- (x <> y) <> (z <> (t <> u)) =
-- (x <> y) <> ((z <> t) <> u) =
-- (x <> (y <> z)) <> (t <> u) =
-- ((x <> y) <> z) <> (t <> u) =
-- (x <> (y <> (z <> t))) <> u =
-- (x <> ((y <> z) <> t)) <> u =
-- ((x <> (y <> z)) <> t) <> u =
-- (((x <> y) <> z) <> t) <> u = [x,y,z,t,u]
-- 
-- ...











































































































main :: IO ()
main = putStrLn "typechecks."
