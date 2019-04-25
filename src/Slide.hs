module Slide where

import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import Control.Monad.Trans.Control
import Control.Monad.IO.Class
import Data.Aeson ((.=))
import qualified Data.Aeson as Aeson


runMyFileTest :: IO ()
runMyFileTest = runGoldenTest $ do
  r <- ask
  s <- get
  (((), s'), w) <- liftIO $ withFile "deployment-key.txt" $ \handle -> do
    runWriterT . flip runStateT s . flip runReaderT r $ do
      deploymentKey <- hGetContents handle
      sendPayload $ Aeson.object
        [ "request"       .= Aeson.String "getPowerStates"
        , "deploymentKey" .= deploymentKey
        ]
  put s'
  tell w

withFile :: FilePath
         -> (Handle -> IO a)
         -> IO a

runGoldenTest :: ReaderT Connection
                   (StateT [Aeson.Value]
                     (WriterT [Aeson.Value]
                       IO)) a
              -> IO a



















































































data Handle = Handle
data Connection = Connection

withFile _ body = body Handle

hGetContents :: MonadIO m => Handle -> m String
hGetContents Handle = pure "<file contents>"

sendPayload :: ( MonadReader Connection m
               , MonadState [Aeson.Value] m
               , MonadWriter [Aeson.Value] m
               )
            => Aeson.Value
            -> m ()
sendPayload x = do
  modify (++ [x])
  tell [x]

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
