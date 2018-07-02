module Slide where
import Control.Monad.IO.Class
import Data.Conduit

main :: IO () --         [1,2,3]      [1,1,2,2,3,3]
main = runConduit $ listSource [1..3] .| stutter .| printAll


listSource :: Monad m
           => [o] -> ConduitT i o m ()
listSource []     = pure ()
listSource (x:xs) = do
  yield x
  listSource xs

stutter :: Monad m
        => ConduitT a a m ()
stutter = await >>= \case
  Nothing -> pure ()
  Just i  -> do
    yield i
    yield i
    stutter

printAll :: (Show i, MonadIO m)
         => ConduitT i o m ()
printAll = await >>= \case
  Nothing -> pure ()
  Just i  -> do
    liftIO $ print i
    printAll































































































