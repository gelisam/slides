{-# LANGUAGE TypeFamilies #-}
module Main where
import Test.DocTest

import Control.Exception
import Control.Monad.IO.Class
import Control.Monad.State

class MonadIO m => ToIO m where
  type Captured m
  capture :: m (Captured m)
  restore :: Captured m -> m ()
  toIO :: m a
       -> Captured m -> IO (a, Captured m)

-- |
-- >>> :{
-- flip execStateT "foo" $ do
--   liftedWithFile "myfile" $ modify (++ "!")
-- :}
-- opening myfile
-- closing myfile
-- "foo!"
liftedWithFile :: (MonadIO m, ToIO m) => FilePath -> m a -> m a
liftedWithFile filePath body = do
  captured <- capture
  (x, captured') <- liftIO $ withFile filePath (toIO body captured)
  restore captured'
  pure x

-- |
-- >>> :{
-- flip execStateT "foo" $ do
--   modify (++ "!") `liftedFinally` do
--     s <- get
--     liftIO $ print s
--     modify (++ "?")
-- :}
-- "foo"
-- "foo!"
liftedFinally :: (MonadIO m, ToIO m) => m a -> m b -> m a
liftedFinally body finalizer = do
  captured <- capture
  (x, captured') <- liftIO $ finally (toIO body      captured)
                                     (toIO finalizer captured)
  restore captured'
  pure x














































withFile :: FilePath -> IO a -> IO a
withFile filePath body = do
  putStrLn ("opening " ++ filePath)
  x <- body
  putStrLn ("closing " ++ filePath)
  pure x



instance ToIO IO where
  type Captured IO = ()
  capture = pure ()
  restore () = pure ()
  toIO body () = do
    x <- body
    pure (x, ())

instance ToIO m => ToIO (StateT s m) where
  type Captured (StateT s m) = (s, Captured m)
  capture = do
    s <- get
    captured <- lift capture
    pure (s, captured)
  restore (s, captured) = do
    put s
    lift $ restore captured
  toIO body (s, captured) = do
    ((x, s'), captured') <- toIO (runStateT body s) captured
    pure (x, (s', captured'))


main :: IO ()
main = doctest ["src/Main.hs"]
