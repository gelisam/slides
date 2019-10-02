module Main where


data UIState = UIState
  { messages :: [Message]
  , buffer   :: String
  }

draw :: UIState -> Doc

update :: Event -> UIState -> (UIState, [Request])
update event s = case event of
  Idle                -> (s, [LoadMessages])

  MessagesLoaded msgs -> (s { messages = msgs }, [])

  KeyDown Enter       -> let msg = Message "human" (buffer s)
                         in (s { messages = [] }, [SendMessage msg])
                                 -- ^ should have been buffer

  KeyDown Backspace   -> let buf = buffer s
                         in (s { buffer = take (length buf - 1) buf }, [])

  KeyDown (Char c)    -> (s { buffer = buffer s ++ [c] }, [])

  _                   -> (s, [])





























































































data Doc

draw = undefined


data Event = Idle | KeyDown Key | KeyUp Key | MessagesLoaded [Message]
data Key = Enter | Backspace | Esc | Char Char


data Message = Message String String
data Request = LoadMessages | SendMessage Message



main :: IO ()
main = putStrLn "typechecks."
