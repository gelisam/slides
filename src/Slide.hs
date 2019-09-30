module Main where
import Data.IORef                                                                                                                                                                                                        ; import Control.Lens; import qualified Data.Sequence as Seq; import Data.Foldable as Seq (toList); import qualified Data.Map as Map; import Data.Map (Map)

-- ROF-based implementation


-- sendMessage  (pickChannel rof channel) :: Message -> IO ()
-- loadMessages (pickChannel rof channel) :: IO [Message]
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
































sendChannelMessage :: MultiChannelROF -> Channel -> Message -> IO ()
sendChannelMessage rof channel msg = do
  sendMessage  (pickChannel rof channel) msg

loadChannelMessages :: MultiChannelROF -> Channel -> IO [Message]
loadChannelMessages rof channel = do
  loadMessages (pickChannel rof channel)



















































































































data ChannelROF = ChannelROF
  { sendMessage  :: Message -> IO ()
  , loadMessages :: IO [Message]
  }


newtype User = User
  { unUser :: String }
  deriving (Eq, Ord, Show)

human :: User
human = User "human"


data Message = Message
  { author   :: User
  , contents :: String
  }
  deriving (Eq, Show)


newtype Channel = Channel
  { unChannel :: String }
  deriving (Eq, Ord, Show)


main :: IO ()
main = putStrLn "typechecks."
