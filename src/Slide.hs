{-# LANGUAGE NamedFieldPuns, RankNTypes #-}
module Main where
import Control.Monad.Reader
import Control.Monad.State                                                                                                                                                                                                        ; import Control.Lens; import Control.Concurrent; import Data.IORef; import qualified Data.Sequence as Seq; import Data.Foldable as Seq (toList); import Data.Map (Map); import qualified Data.Map as Map


type Chatbot      = ReaderT ChannelROF      (StateT              Int  IO)
type MultiChatbot = ReaderT MultiChannelROF (StateT (Map Channel Int) IO)

waitChannelRequest :: Channel -> MultiChatbot Message
waitChannelRequest channel = do
  magnify (to (flip pickChannel channel)) $ do
    zoom (at channel . non 0) $ do
      waitRequest

sendChannelResponse :: Channel -> Message -> MultiChatbot ()
sendChannelResponse channel msg = do
  magnify (to (flip pickChannel channel)) $ do
    zoom (at channel . non 0) $ do
      sendResponse msg



























































































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


data MultiChannelROF = MultiChannelROF
  { pickChannel  :: Channel -> ChannelROF
  , listChannels :: IO (Map Channel Int)  -- number of messages in each channel
  }

localMultiChannelROF :: IO MultiChannelROF
localMultiChannelROF = do
  ref <- newIORef Map.empty
  pure $ MultiChannelROF
    { pickChannel = \channel -> ChannelROF
        { sendMessage = \msg -> do
            modifyIORef ref $ over (at channel . non Seq.empty) (|> msg)
        , loadMessages = do
            view (at channel . non Seq.empty . to Seq.toList) <$> readIORef ref
        }
    , listChannels = fmap Seq.length <$> readIORef ref
    }



-- 1 second = 1 million microseconds
sleep :: Int -> IO ()
sleep seconds = threadDelay (seconds * 1000000)



data Message = Message { author :: String, contents :: String }
  deriving (Eq, Ord)

newtype Channel = Channel { channelName :: String }
  deriving (Eq, Ord)




main :: IO ()
main = putStrLn "typechecks."
