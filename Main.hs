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

data FreeMonoid a where
    Nil  :: FreeMonoid a
    Cons :: a -> FreeMonoid a -> FreeMonoid a

instance Monoid (FreeMonoid a) where
    mempty = Nil
    Nil       `mappend` ys = ys
    Cons x xs `mappend` ys = Cons x (xs `mappend` ys)

singleton :: a -> FreeMonoid a
singleton x = Cons x Nil









































































































main :: IO ()
main = putStrLn "typechecks."
