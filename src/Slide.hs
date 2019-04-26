module Slide where

                                 fork :: MonadUnliftIO m
forkIO :: IO a -> IO ThreadId         => m a -> m ThreadId
                     --MonadUnliftIO-->

                  --(MonadIO, MonadMask)-->
                                 withFile :: (MonadIO m, MonadMask m)
withFile :: FilePath                      => FilePath
         -> (Handle -> IO a)              -> (Handle -> m a)
         -> IO a                          -> m a



                                 traverse :: Applicative f
fmap :: (a -> b)                          => (a -> f b)
     -> [a] -> [b]                        -> [a] -> f [b]
                     --Applicative-->

                        --Monad-->
                                 unfoldrM :: Monad m
unfoldr :: (a -> Maybe (b, a))            => (a -> m (Maybe (b, a)))
        -> a -> [b]                       -> a -> m [b]






















































































main :: IO ()
main = putStrLn "typechecks."
