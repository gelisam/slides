{-# LANGUAGE NamedFieldPuns #-}
module Main where
import Control.Monad.Reader
import Control.Monad.State                                                                                                                                                                                                        ; import Control.Lens; import Control.Concurrent; import Data.IORef; import qualified Data.Sequence as Seq; import Data.Foldable as Seq (toList)


--                          number of messages seen so far
--                                         |
--                                         v
type Chatbot = ReaderT ChannelROF (StateT Int IO)

waitRequest :: Chatbot Message
waitRequest = do
  channelROF <- ask
  seenCount <- get
  allMsgs <- liftIO $ loadMessages channelROF
  let newMsgs = drop seenCount allMsgs
  case newMsgs of
    [] -> do
      liftIO $ sleep 1
      waitRequest
    newMsg : _ -> do
      modify (+1)
      pure newMsg

sendResponse :: Message -> Chatbot ()
sendResponse msg = do
  channelROF <- ask
  liftIO $ sendMessage channelROF msg






























































































data ChannelROF = ChannelROF
  { sendMessage  :: Message -> IO ()
  , loadMessages :: IO [Message]
  }

localChannelROF :: IO ChannelROF
localChannelROF = do
  ref <- newIORef Seq.empty
  pure $ ChannelROF
    { sendMessage  = \msg -> modifyIORef ref (|> msg)
    , loadMessages = Seq.toList <$> readIORef ref
    }


-- 1 second = 1 million microseconds
sleep :: Int -> IO ()
sleep seconds = threadDelay (seconds * 1000000)


data Message = Message { author :: String, contents :: String }

newtype Channel = Channel { channelName :: String }




main :: IO ()
main = putStrLn "typechecks."
