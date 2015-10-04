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

type FreeMonoid a = [a]













































































































main :: IO ()
main = putStrLn "typechecks."
