module Main where
import Control.Monad.State

-- transformer-based implementation


type ChannelState = [Message]

loadMessages :: State ChannelState [Message]
loadMessages = get

sendMessage :: Message -> State ChannelState ()
sendMessage msg = do
  modify (++ [msg])





























































































data Message = Message { author :: String, contents :: String }
  deriving Eq

newtype Channel = Channel { channelName :: String }
  deriving (Eq, Ord)




main :: IO ()
main = putStrLn "typechecks."
