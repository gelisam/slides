{-# LANGUAGE LambdaCase, RecursiveDo #-}
module Main where

import Reactive.Banana                                                                                                                                                                                                         as Frp (Behavior, accumB, unions, filterE, filterJust, (<@)); import qualified Reactive.Banana as Frp; import Reactive.Banana.Frameworks (MomentIO)


data UIState = UIState
  { messages :: [Message]
  , buffer   :: String
  }

draw :: UIState -> Doc

ui :: Stream Event
   -> Frp (Behavior Doc, Stream [Request])
ui eventS = mdo
  let idleS      = filterS (== Idle)              eventS
  let enterS     = filterS (== KeyDown Enter)     eventS
  let backspaceS = filterS (== KeyDown Backspace) eventS
  let charS          = flip mapMaybeS eventS $ \case
                         KeyDown (Char c) -> Just c
                         _                -> Nothing
  let messagesLoaded = flip mapMaybeS eventS $ \case
                         MessagesLoaded msgs -> Just msgs
                         _                   -> Nothing

  let sendMessagesS = (Message "message" <$> bufferB)
                   <@ enterS
  let requestS = ((\_   -> [LoadMessages])    <$> idleS)
              <> ((\msg -> [SendMessage msg]) <$> sendMessagesS)

  messagesB <- accumB [] $ unions
    [ const <$> messagesLoaded
    , const [] <$ sendMessagesS  -- should be here instead
    ]                            --             |
                                 --             |
  bufferB <- accumB "" $ unions  --             |
    [ const [] <$ sendMessagesS  -- <-----------'
    , (\buf -> take (length buf - 1) buf) <$ backspaceS
    , (\c buf -> buf ++ [c]) <$> charS
    ]

  let uiStateB :: Behavior UIState
      uiStateB = UIState <$> messagesB <*> bufferB 

  let docB :: Behavior Doc
      docB = draw <$> uiStateB

  pure (docB, requestS)
  





































type Frp = MomentIO

type Stream a = Frp.Event a

filterS :: (a -> Bool) -> Stream a -> Stream a
filterS = filterE

mapMaybeS :: (a -> Maybe b) -> Stream a -> Stream b
mapMaybeS f = filterJust . fmap f



data Doc

draw = undefined


data Event = Idle | KeyDown Key | KeyUp Key | MessagesLoaded [Message]
  deriving Eq
data Key = Enter | Backspace | Esc | Char Char
  deriving Eq


data Message = Message String String
  deriving Eq
data Request = LoadMessages | SendMessage Message
  deriving Eq



main :: IO ()
main = putStrLn "typechecks."
