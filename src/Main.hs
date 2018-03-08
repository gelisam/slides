{-# LANGUAGE InstanceSigs, ScopedTypeVariables #-}
module Main where
import Test.DocTest

import Control.Exception
import Control.Monad.IO.Class
import Control.Monad.State
import Data.IORef


-- |
-- >>> :{
-- flip execStateT "foo" $ do
--   modify (++ "!") `liftedFinally` do
--     s <- get
--     liftIO $ print s
--     modify (++ "?")
-- :}
-- "foo!"
-- "foo!?"
class Monad m => MonadFinally m where
  generalFinally :: m a -> (Maybe a -> m b) -> m (a, b)

liftedFinally :: MonadFinally m
              => m a -> m b -> m a
liftedFinally body finalizer = fst <$> generalFinally body (const finalizer)


instance MonadFinally IO where
  generalFinally :: forall a b
                  . IO a
                 -> (Maybe a -> IO b)
                 -> IO (a, b)
  generalFinally body finalizer = do
    aRef <- newIORef Nothing
    bRef <- newIORef undefined
    let body' :: IO a
        body' = do
          a <- body
          writeIORef aRef (Just a)
          pure a
        finalizer' :: IO ()
        finalizer' = do
          aMay <- readIORef aRef
          b <- finalizer aMay
          writeIORef bRef b
    a <- finally body' finalizer'
    b <- readIORef bRef
    pure (a, b)

instance MonadFinally m => MonadFinally (StateT s m) where
  generalFinally :: forall  a b
                  . StateT s m a
                 -> (Maybe a -> StateT s m b)
                 -> StateT s m (a, b)
  generalFinally body finalizer = StateT $ \s0 -> do
    let body' :: m (a, s)
        body' = runStateT body s0
        finalizer' :: Maybe (a, s) -> m (b, s)
        finalizer' (Just (a, s1)) = runStateT (finalizer (Just a)) s1
        finalizer' Nothing        = runStateT (finalizer Nothing)  s0
    ((a, _s1), (b, s2)) <- generalFinally body' finalizer'
    pure ((a, b), s2)















































withFile :: FilePath -> IO a -> IO a
withFile filePath body = do
  putStrLn ("opening " ++ filePath)
  x <- body
  putStrLn ("closing " ++ filePath)
  pure x



main :: IO ()
main = doctest ["src/Main.hs"]
