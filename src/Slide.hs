{-# LANGUAGE NamedFieldPuns #-}
module Main where
import Control.Monad                                                                                                                                                                                                        ; import Data.Foldable


waitRequest  :: M Message
sendResponse :: Message -> M ()


respondingBot :: String -> (String -> Maybe String) -> M a
respondingBot botName f = forever $ do
  Message {author, contents} <- waitRequest
  unless (author == botName) $ do
    for_ (f contents) $ \response -> do
      sendResponse (Message botName response)

echobot :: M ()
echobot = respondingBot "echobot" Just































































































type M = IO

data Message = Message { author :: String, contents :: String }

newtype Channel = Channel { channelName :: String }

waitRequest  = undefined
sendResponse = undefined


main :: IO ()
main = putStrLn "typechecks."
