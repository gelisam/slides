module Slide where

import Control.Concurrent
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import Control.Monad.Trans.Control
import Control.Monad.IO.Class
import Data.Aeson ((.=))
import qualified Data.Aeson as Aeson


runMyFileTest :: IO ()
runMyFileTest = runGoldenTest $ do

  liftBaseWith $ \runInIO -> do
    threadId <- liftIO $ forkIO $ do
      stM <- runInIO $ do
        deploymentKey <- hGetContents
        sendPayload $ Aeson.object
          [ "request"       .= Aeson.String "getPowerStates" 
          , "deploymentKey" .= deploymentKey
          ]
      pure ()
    pure ()
  --restoreM stM

-- forkIO :: IO a -> IO a



























































































data Handle = Handle
data Connection = Connection

withFile _ body = body Handle

hGetContents :: MonadIO m => m String
hGetContents = pure "<file contents>"

sendPayload :: ( MonadReader Connection m
               , MonadState [Aeson.Value] m
               , MonadWriter [Aeson.Value] m
               )
            => Aeson.Value
            -> m ()
sendPayload x = do
  modify (++ [x])
  tell [x]

runGoldenTest :: ReaderT Connection
                   (StateT [Aeson.Value]
                     (WriterT [Aeson.Value]
                       IO)) a
              -> IO a
runGoldenTest body = do
  ((a, s), w) <- runWriterT
               . flip runStateT []
               . flip runReaderT Connection
               $ body
  putStrLn $ "final state: " ++ show s
  putStrLn $ "final write: " ++ show w
  pure a


main :: IO ()
main = putStrLn "typechecks."
