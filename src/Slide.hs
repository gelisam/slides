module Main where


-- ROF-based implementation


-- sendMessage  :: ChannelROF -> Message -> IO ()
-- loadMessages :: ChannelROF -> IO [Message]
data ChannelROF = ChannelROF
  { sendMessage  :: Message -> IO ()
  , loadMessages :: IO [Message]
  }

localChannelROF :: IO ChannelROF
remoteChannelROF :: URL -> IO ChannelROF


















































































































type URL = ()

localChannelROF = undefined
remoteChannelROF = undefined


data Message = Message


main :: IO ()
main = putStrLn "typechecks."
