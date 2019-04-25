module Slide where

import Control.Concurrent
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import "lifted-base" Control.Concurrent.Lifted (fork)
import Control.Monad.IO.Class
import Data.Aeson ((.=))
import qualified Data.Aeson as Aeson


runMyFileTest :: IO ()
runMyFileTest = runGoldenTest $ do


  threadId <- fork $ do

        deploymentKey <- hGetContents
        sendPayload $ Aeson.object
          [ "request"       .= Aeson.String "getPowerStates" 
          , "deploymentKey" .= deploymentKey
          ]

  pure ()


-- fork :: MonadBaseControl IO m => m a -> m a
--
-- Generalized version of forkIO.
--
-- Note that, while the forked computation m () has access to the captured
-- state, all its side-effects in m are discarded. It is run only for its
-- side-effects in IO.



























































































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
