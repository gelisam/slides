{-# LANGUAGE BangPatterns, GADTs, MultiParamTypeClasses #-}
import Prelude hiding (id)
import Control.Monad

data FreeMonad m a where
    MNil  :: a -> FreeMonad m a
    MCons :: m a -> (a -> FreeMonad m b) -> FreeMonad m b

-- Interlude:
-- Pattern-matching on monadic computations?


isDivisorM :: Int -> Int -> FreeMonad IO Bool
isDivisorM n d = singletonM $ isDivisorIO n d




divisorsM  :: FreeMonad IO [Int]
divisorsM  = filterM (isDivisorM  6) [1..5]

divisorsM' :: FreeMonad IO [Int]
divisorsM' =    MCons (isDivisorIO 6 1) $ \b1 ->
                MCons (isDivisorIO 6 2) $ \b2 ->
                MCons (isDivisorIO 6 3) $ \b3 ->
                MCons (isDivisorIO 6 4) $ \b4 ->
                MCons (isDivisorIO 6 5) $ \b5 ->
                MNil    $ (if b1 then (1:) else id)
                        $ (if b2 then (2:) else id)
                        $ (if b3 then (3:) else id)
                        $ (if b4 then (4:) else id)
                        $ (if b5 then (5:) else id)
                        $ []






























































































isDivisorIO :: Int -> Int -> IO Bool
isDivisorIO n d = do
    putStrLn "crunching numbers"
    return $ isDivisor n d








isDivisor :: Int -> Int -> Bool
isDivisor n d = (n `mod` d) == 0



data MonoidAST a where
    Base   :: a -> MonoidAST a
    MEmpty  :: MonoidAST a
    MAppend :: MonoidAST a -> MonoidAST a -> MonoidAST a

data FreeMonoid a where
    Nil  :: FreeMonoid a
    Cons :: a -> FreeMonoid a -> FreeMonoid a

instance Monoid (FreeMonoid a) where
    mempty = Nil
    Nil `mappend` ys = ys
    Cons x xs `mappend` ys = Cons x (xs `mappend` ys)

singleton :: a -> FreeMonoid a
singleton x = Cons x Nil


data MonadAST m a where
    MBase   :: m a -> MonadAST m a
    MReturn :: a -> MonadAST m a
    MBind   :: MonadAST m a -> (a -> MonadAST m b) -> MonadAST m b

instance Functor (FreeMonad m) where
    fmap f (MNil x)      = MNil (f x)
    fmap f (MCons mx cc) = MCons mx $ fmap (fmap f) cc

instance Applicative (FreeMonad m) where
    pure = MNil
    MNil f      <*> fmx = fmap f fmx
    MCons mx cc <*> fmx = MCons mx $ fmap (<*> fmx) cc

instance Monad (FreeMonad m) where
    return = MNil
    MNil x      >>= f = f x
    MCons mx cc >>= f = MCons mx $ fmap (>>= f) cc

singletonM :: m a -> FreeMonad m a
singletonM mx = MCons mx MNil


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

instance Category (->) where
    id x = x
    (>>>) = flip (.)

singletonC :: k a b -> FreeCategory k a b
singletonC f = CCons f CNil


main :: IO ()
main = putStrLn "typechecks."
