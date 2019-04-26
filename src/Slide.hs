module Slide where

foo :: ( MonadReader A m         foo :: ReaderT (A, IORef B, IORef C) IO a
       , MonadState  B m
       , MonadWriter C m
       , MonadIO m
       ) a
    -> m a

bar :: ( MonadReader A m         bar :: Reader (A, IORef B, IORef C) a
       , MonadState  B m         bar :: ReaderT (A, IORef B, IORef C) IO a
       , MonadWriter C m
       ) a
    -> m a























































































main :: IO ()
main = putStrLn "typechecks."
