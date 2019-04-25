module Slide where

import Control.Concurrent
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import Control.Monad.IO.Class
import Data.Aeson ((.=))
import Data.IORef
import qualified Data.Aeson as Aeson


runMyFileTest :: IO ()
runMyFileTest = runGoldenTest $ do
  r <- ask

  threadId <- liftIO $ forkIO $ do
    threadId <- flip runReaderT r $ do
        deploymentKey <- hGetContents
        sendPayload $ Aeson.object
          [ "request"       .= Aeson.String "getPowerStates" 
          , "deploymentKey" .= deploymentKey
          ]
    pure ()
  pure ()



runGoldenTest :: ReaderT ( Connection
                         , IORef [Aeson.Value]
                         , IORef [Aeson.Value]
                         )
                         IO a
              -> IO a



























































































data Handle = Handle
data Connection = Connection

withFile _ body = body Handle

hGetContents :: MonadIO m => m String
hGetContents = pure "<file contents>"

sendPayload :: Aeson.Value
            -> ReaderT ( Connection
                       , IORef [Aeson.Value]
                       , IORef [Aeson.Value]
                       )
                       IO ()
sendPayload x = do
  (Connection, sRef, wRef) <- ask
  liftIO $ modifyIORef sRef (++ [x])
  liftIO $ modifyIORef wRef (++ [x])

runGoldenTest body = do
  sRef <- newIORef []
  wRef <- newIORef []
  a <- flip runReaderT (Connection, sRef, wRef) body
  s <- readIORef sRef
  w <- readIORef wRef
  putStrLn $ "final state: " ++ show s
  putStrLn $ "final write: " ++ show w
  pure a


main :: IO ()
main = putStrLn "typechecks."
