module Main where
import Data.Map (Map)


data Message = Message { author :: String, contents :: String }

sendMessage  :: Message -> M ()
loadMessages :: M [Message]


newtype Channel = Channel { channelName :: String }

sendChannelMessage  :: Channel -> Message -> M ()
loadChannelMessages :: Channel -> M [Message]

-- number of messages in each channel
listChannels :: M (Map Channel Int)





















































































































type M = IO

sendMessage  = undefined
loadMessages = undefined

listChannels = undefined
sendChannelMessage  = undefined
loadChannelMessages = undefined



main :: IO ()
main = putStrLn "typechecks."
