module Main where
import Control.Monad.State                                                                                                                                                                                                        ; import Control.Lens; import Data.Foldable as Seq (toList); import Data.Map (Map); import Data.Sequence (Seq); import qualified Data.Sequence as Seq; import qualified Data.Foldable as List; import qualified Data.Map as Map; import Data.Traversable

-- transformer-based implementation


type ChannelState = Seq Message

loadMessages :: State ChannelState [Message]
loadMessages = Seq.toList <$> get

sendMessage :: Message -> State ChannelState ()
sendMessage msg = do
  modify (|> msg)


type MultiChannelState = Map Channel ChannelState

sendChannelMessage :: Channel -> Message -> State MultiChannelState ()
sendChannelMessage channel msg = do
  zoom (at channel . non Seq.empty) $ do
    -- now running in "State ChannelState"
    sendMessage msg

loadChannelMessages :: Channel -> State MultiChannelState [Message]
loadChannelMessages channel = do
  zoom (at channel . non Seq.empty) $ do
    loadMessages


whiteboxListChannels :: State MultiChannelState (Map Channel Int)
whiteboxListChannels = do
  multiState <- get
  pure (fmap Seq.length multiState)

blackboxListChannels :: State MultiChannelState (Map Channel Int)
blackboxListChannels = do
  multiState <- get
  pairs <- for (Map.keys multiState) $ \channel -> do
    zoom (at channel . non Seq.empty) $ do
      msgs <- loadMessages
      pure (channel, List.length msgs)
  pure (Map.fromList pairs)


























































































data Message = Message { author :: String, contents :: String }
  deriving Eq

newtype Channel = Channel { channelName :: String }
  deriving (Eq, Ord)




main :: IO ()
main = putStrLn "typechecks."
