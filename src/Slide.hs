module Main where


registerCallbacks :: ChannelROF -> IO ()
registerCallbacks channelROF = do
  bufferBox <- newTextBox
  msgBox <- newTextBox

  let onIdle :: IO ()
      onIdle = do
        msgs <- loadMessages channelROF
        setText msgBox $ foldMap renderMessage msgs
        setTimeout 5 onIdle
  setTimeout 5 onIdle

  let onKeyDown :: Key -> IO ()
      onKeyDown Enter = do
        buf <- getText bufferBox
        sendMessage channelROF (Message "human" buf)
        setText msgBox ""
      onKeyDown Backspace = do
        buf <- getText bufferBox
        setText bufferBox $ take (length buf - 1) buf
      onKeyDown (Char c) = do
        buf <- getText bufferBox
        setText bufferBox $ buf ++ [c]
      onKeyDown _ = do
        pure ()
  setOnKeyDown onKeyDown


































































































data Key = Enter | Backspace | Esc | Char Char

setOnKeyDown :: (Key -> IO ()) -> IO ()
setOnKeyDown = undefined

setTimeout :: Int -> IO () -> IO ()
setTimeout = undefined


data TextBox

newTextBox :: IO TextBox
newTextBox = undefined

getText :: TextBox -> IO String
getText = undefined

setText :: TextBox -> String -> IO ()
setText = undefined



data ChannelROF
data Message = Message String String

renderMessage :: Message -> String
renderMessage = undefined

loadMessages :: ChannelROF -> IO [Message]
loadMessages = undefined

sendMessage :: ChannelROF -> Message -> IO ()
sendMessage = undefined


main :: IO ()
main = putStrLn "typechecks."
