{-# LANGUAGE LambdaCase, RecursiveDo #-}
module Main where

import Reactive.Banana                                                                                                                                                                                                         as Frp (Behavior); import qualified Reactive.Banana as Frp; import Reactive.Banana.Frameworks (MomentIO); import Data.Foldable


ui :: Stream Event
   -> Frp (Behavior Doc, Stream [Request])

registerCallbacks :: ChannelROF -> IO ()
registerCallbacks channelROF = do
  (eventS, sendEvent) <- newStream
  (docB, requestS) <- runFrp (ui eventS)

  onBehaviourChange docB $ \doc -> do
    clearScreen
    putDocLn doc

  onStreamEmit requestS $ \requests -> do
    for_ requests $ \case
      LoadMessages -> do
        msgs <- loadMessages channelROF
        sendEvent (MessagesLoaded msgs)
      SendMessage msg -> do
        sendMessage channelROF msg

  let onIdle :: IO ()
      onIdle = do
        sendEvent Idle
        setTimeout 5 onIdle
  setTimeout 5 onIdle
  setOnKeyDown (sendEvent . KeyDown)







































ui = undefined

type Frp = MomentIO

runFrp :: Frp a -> IO a
runFrp = undefined


type Stream a = Frp.Event a

newStream :: IO (Stream a, a -> IO ())
newStream = undefined

onBehaviourChange :: Behavior a -> (a -> IO ()) -> IO ()
onBehaviourChange = undefined

onStreamEmit :: Stream a -> (a -> IO ()) -> IO ()
onStreamEmit = undefined



data Doc

clearScreen :: IO ()
clearScreen = undefined

putDocLn :: Doc -> IO ()
putDocLn = undefined


data Event = Idle | KeyDown Key | KeyUp Key | MessagesLoaded [Message]
  deriving Eq
data Key = Enter | Backspace | Esc | Char Char
  deriving Eq

setOnKeyDown :: (Key -> IO ()) -> IO ()
setOnKeyDown = undefined

setTimeout :: Int -> IO () -> IO ()
setTimeout = undefined


data Message = Message String String
  deriving Eq
data Request = LoadMessages | SendMessage Message
  deriving Eq


data ChannelROF

renderMessage :: Message -> String
renderMessage = undefined

loadMessages :: ChannelROF -> IO [Message]
loadMessages = undefined

sendMessage :: ChannelROF -> Message -> IO ()
sendMessage = undefined


main :: IO ()
main = putStrLn "typechecks."
