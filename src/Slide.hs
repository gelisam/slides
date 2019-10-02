{-# LANGUAGE LambdaCase, RecursiveDo, ScopedTypeVariables #-}
module Main where

import Reactive.Banana                                                                                                                                                                                                         as Frp (Behavior, filterE, filterJust, stepper, accumE, (<@>)); import Control.Lens; import Control.Monad (forever); import qualified Reactive.Banana as Frp; import Reactive.Banana.Frameworks (MomentIO); import Data.Void; import Control.Monad.Free


runFreeOp :: Free Op Void
          -> Stream ()  -- initialization
          -> Stream Key
          -> Frp (Behavior String, Stream [Message])
runFreeOp free0 initS keyS = mdo
  let (buffer0, messages0, cc0) = runUntilWait "" free0

  let tripleS :: Stream (String, [Message], Key -> Free Op Void)
      tripleS = runUntilWait <$> bufferB <@> (ccB <@> keyS)

  let bufferS   = view _1 <$> tripleS
  let messagesS = view _2 <$> tripleS
  let ccS       = view _3 <$> tripleS

  bufferB <- stepper buffer0 bufferS
  ccB     <- stepper cc0     ccS

  pure (bufferB, (messages0 <$ initS) <> messagesS)
  



































maintainBuffer :: Free Op Void
maintainBuffer = forever $ do
  key <- waitForKey
  case key of
    Enter -> do
      buf <- get
      send (Message "human" buf)
      put ""

    Backspace -> do
      modify (\buf -> take (length buf - 1) buf)

    Char c -> do
      modify (\buf -> buf ++ [c])

    _ -> do
      pure ()





type Frp = MomentIO

type Stream a = Frp.Event a

filterS :: (a -> Bool) -> Stream a -> Stream a
filterS = filterE

mapMaybeS :: (a -> Maybe b) -> Stream a -> Stream b
mapMaybeS f = filterJust . fmap f

accumS :: a -> Stream (a -> a) -> MomentIO (Stream a)
accumS = accumE



data Op a
  = WaitForKey (Key -> a)
  | Send Message a
  | Get (String -> a)
  | Put String a

runUntilWait :: String
             -> Free Op Void
             -> (String, [Message], Key -> Free Op Void)
runUntilWait = go []
  where
    go msgs s = \case
      Pure void            -> absurd void
      Free (WaitForKey cc) -> (s, msgs, cc)
      Free (Send msg cc)   -> go (msgs ++ [msg]) s cc
      Free (Get cc)        -> go msgs s (cc s)
      Free (Put s' cc)     -> go msgs s' cc
  

instance Functor Op where
  fmap f (WaitForKey cc) = WaitForKey (f . cc)
  fmap f (Send msg a)    = Send msg (f a)
  fmap f (Get cc)        = Get (f . cc)
  fmap f (Put s a)       = Put s (f a)

waitForKey :: Free Op Key
waitForKey = liftF $ WaitForKey id

send :: Message -> Free Op ()
send msg = liftF $ Send msg ()

get :: Free Op String
get = liftF $ Get id

put :: String -> Free Op ()
put s = liftF $ Put s ()

modify :: (String -> String) -> Free Op ()
modify f = do
  s <- get
  put (f s)


data Key = Enter | Backspace | Esc | Char Char
  deriving Eq


data Message = Message String String
  deriving Eq



main :: IO ()
main = putStrLn "typechecks."
