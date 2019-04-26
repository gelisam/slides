module Slide where

                                 fork :: MonadBaseControl m
forkIO :: IO a -> IO ThreadId         => m a -> m ThreadId

                     --MonadBaseControl-->

                                 withFile :: MonadBaseControl m
withFile :: FilePath                      => FilePath
         -> (Handle -> IO a)              -> (Handle -> m a)
         -> IO a                          -> m a

























































































main :: IO ()
main = putStrLn "typechecks."
