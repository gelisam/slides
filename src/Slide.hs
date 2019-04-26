module Slide where

                                 fork :: MonadBaseControl m
forkIO :: IO a -> IO ThreadId         => m a -> m ThreadId


                                 withFile :: MonadBaseControl m
withFile :: FilePath                      => FilePath
         -> (Handle -> IO a)              -> (Handle -> m a)
         -> IO a                          -> m a




fmap :: (a -> b)
     -> [a] -> [b]

                                 

unfoldr :: (a -> Maybe (b, a))
        -> a -> [b]






















































































main :: IO ()
main = putStrLn "typechecks."
