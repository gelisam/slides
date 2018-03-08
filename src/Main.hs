{-# LANGUAGE TypeFamilies #-}
module Main where
import Test.DocTest

import Control.Monad.IO.Class
import Control.Monad.State


class MonadIO m => ToIO m where
  type Captured m
  capture :: m (Captured m)
  restore :: Captured m -> m ()
  toIO :: m a
       -> Captured m -> IO (a, Captured m)

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
