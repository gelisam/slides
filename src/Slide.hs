{-# LANGUAGE LambdaCase, RecursiveDo #-}
module Main where

import Reactive.Banana                                                                                                                                                                                                         as Frp (Behavior, accumB, unions, filterE, filterJust, (<@)); import qualified Reactive.Banana as Frp; import Reactive.Banana.Frameworks (MomentIO)


buffer :: Stream Key
       -> Frp (Behavior String, Stream Message)
buffer keyS = mdo
  let enterS     = filterS (== Enter)     keyS
  let backspaceS = filterS (== Backspace) keyS
  let charS      = flip mapMaybeS keyS $ \case
                     Char c -> Just c
                     _      -> Nothing

  let sendMessagesS = (Message "message" <$> bufferB)
                   <@ enterS

  bufferB <- accumB "" $ unions
    [ const [] <$ sendMessagesS
    , (\buf -> take (length buf - 1) buf) <$ backspaceS
    , (\c buf -> buf ++ [c]) <$> charS
    ]

  pure (bufferB, sendMessagesS)
  





































type Frp = MomentIO

type Stream a = Frp.Event a

filterS :: (a -> Bool) -> Stream a -> Stream a
filterS = filterE

mapMaybeS :: (a -> Maybe b) -> Stream a -> Stream b
mapMaybeS f = filterJust . fmap f



data Key = Enter | Backspace | Esc | Char Char
  deriving Eq


data Message = Message String String
  deriving Eq



main :: IO ()
main = putStrLn "typechecks."
