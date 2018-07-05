module Slide where
import Control.Monad.IO.Class
import Data.Conduit

main :: IO () --         [1,2,3]      [1,1,2,2,3,3]
main = runConduit $ listSource [1..3] .| stutter .| printAll


listSource :: (Show o, MonadIO m)
           => [o] -> ConduitT i o m ()
listSource []     = verboseStop "listSource" ()
listSource (x:xs) = do
  verboseYield "listSource" x
  listSource xs

stutter :: (Show a, MonadIO m)
        => ConduitT a a m ()
stutter = verboseAwait "stutter" >>= \case
  Nothing -> verboseStop "stutter" ()
  Just i  -> do
    verboseYield "stutter" i
    verboseYield "stutter" i
    stutter

printAll :: (Show i, MonadIO m)
         => ConduitT i o m ()
printAll = verboseAwait "printAll" >>= \case
  Nothing -> verboseStop "printAll" ()
  Just i  -> do
    liftIO $ print i
    printAll



























































































verboseAwait :: MonadIO m
             => String -> ConduitT i o m (Maybe i)
verboseAwait label = do
  liftIO $ putStrLn $ Prelude.take 10 (label ++ repeat ' ') ++ " awaits"
  await

verboseYield :: (Show o, MonadIO m)
             => String -> o -> ConduitT i o m ()
verboseYield label o = do
  liftIO $ putStrLn $ Prelude.take 10 (label ++ repeat ' ') ++ " yields " ++ show o
  yield o

verboseStop :: MonadIO m
            => String -> a -> ConduitT i o m a
verboseStop label a = do
  liftIO $ putStrLn $ Prelude.take 10 (label ++ repeat ' ') ++ " stops"
  pure a
