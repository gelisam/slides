{-# LANGUAGE GADTs, MultiParamTypeClasses #-}
import Prelude hiding (Monoid(..), Monad(..), id, (.))

-- f >>> id = f
-- id >>> g = g
-- (f >>> g) >>> h = f >>> (g >>> h)
class Category k where                -- class Category k where
    id    :: k a a                    --     id  :: k a a
    (>>>) :: k a b -> k b c -> k a c  --     (.) :: k b c -> k a b -> k a c

data CategoryAST k a b where
    CBase :: k a b -> CategoryAST k a b
    CId   :: CategoryAST k a a
    CThen :: CategoryAST k a b -> CategoryAST k b c -> CategoryAST k a c

data FreeCategory k a b where
    CNil  :: FreeCategory k a a
    CCons :: k a b -> FreeCategory k b c -> FreeCategory k a c

instance Category (FreeCategory k) where
    id = CNil
    CNil       >>> g = g
    CCons f cc >>> g = CCons f $ cc >>> g

singletonC :: k a b -> FreeCategory k a b
singletonC f = CCons f CNil












































































































main :: IO ()
main = putStrLn "typechecks."
