module Main where
import Control.Monad.State                                                                                                                                                                                                        ; import Control.Lens; import Data.Sequence (Seq); import qualified Data.Foldable as Seq

-- transformer-based implementation


type ChannelState = Seq Message

loadMessages :: State ChannelState [Message]
loadMessages = Seq.toList <$> get

sendMessage :: Message -> State ChannelState ()
sendMessage msg = do
  modify (|> msg)





























































































data Message = Message { author :: String, contents :: String }
  deriving Eq

newtype Channel = Channel { channelName :: String }
  deriving (Eq, Ord)




main :: IO ()
main = putStrLn "typechecks."
