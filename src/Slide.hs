{-# LANGUAGE DeriveFunctor, FlexibleContexts, FlexibleInstances, FunctionalDependencies, GADTs, GeneralizedNewtypeDeriving, InstanceSigs, LambdaCase, MultiParamTypeClasses, NumericUnderscores, RankNTypes, RecordWildCards, RecursiveDo, ScopedTypeVariables, TemplateHaskell, TupleSections, TypeApplications, TypeFamilies, UndecidableInstances #-}
module Main where
import Prelude hiding (putChar, putStr, putStrLn)                                                                                                    ; import qualified Prelude
import Control.Lens
import Control.Monad.State
import Data.Foldable
import qualified System.Terminal as Term


putWrappedChar :: Char -> StateT Int Teletype ()
putWrappedChar c = do
  if c == '\n'
  then do
    lift $ putStringLn ""
    put 0
  else do
    col <- get
    if col >= 20
    then do
      lift $ putStringLn ""
      put 0
    else do
      modify (+1)
    lift $ putString [c]

putWrappedString :: String -> StateT Int Teletype ()
putWrappedString = mapM_ putWrappedChar

putWrappedStringLn :: String -> StateT Int Teletype ()
putWrappedStringLn s = putWrappedString s >> putWrappedChar '\n'

putWrappedUsername :: String -> StateT Int Teletype ()
putWrappedUsername name = do
  lift $ setAttribute Bold
  putWrappedString name
  lift $ resetAttribute Bold

putWrappedMessageLn :: String -> String -> StateT Int Teletype ()
putWrappedMessageLn user msg = do
  putWrappedUsername user
  putWrappedString ": "
  putWrappedStringLn msg

putChannelLn :: Bool -> String -> Teletype ()
putChannelLn active name = do
  when active $ setAttribute Inverted
  putStringLn name
  when active $ resetAttribute Inverted

execTeletype :: Teletype a -> Doc

chat :: [String] -> String -> [(String, String)] -> Doc
chat channels currentChannel messages
    = execTeletype printChannels
  .|. string "  "
  .|. execTeletype printMessages
  where
    printChannels :: Teletype ()
    printChannels = do
      for_ channels $ \channelName -> do
        putChannelLn (channelName == currentChannel) channelName

    printMessages :: Teletype ()
    printMessages = flip evalStateT 0 $ do
      for_ messages $ \(user, msg) -> do
        putWrappedMessageLn user msg

main :: IO ()
main = runTerminal $ do
  liftIO $ Prelude.putStrLn ""
  putDocLn $ chat ["general", "random"] "general"
                  [ ("human",   "hello echobot, how are you?")
                  , ("echobot", "hello echobot, how are you?")
                  ]
  liftIO $ Prelude.putStrLn ""








































































































data TeletypeState = TeletypeState
  { _previousLines     :: Doc
  , _currentLine       :: Doc
  , _currentlyBold     :: Bool
  , _currentlyInverted :: Bool
  }

initialTeletypeState :: TeletypeState
initialTeletypeState = TeletypeState empty empty False False

runTeletypeState :: TeletypeState -> Doc
runTeletypeState (TeletypeState {..}) = _previousLines
                                    .-. _currentLine


newtype Teletype a = Teletype
  { unTeletype :: State TeletypeState a }
  deriving (Functor, Applicative, Monad)

runTeletype :: Teletype a -> (a, Doc)
runTeletype = over _2 runTeletypeState . flip runState initialTeletypeState . unTeletype

execTeletype = snd . runTeletype


putString :: String -> Teletype ()
putString str = Teletype $ do
  s <- get
  let styled :: Doc -> Doc
      styled = (if s ^. currentlyBold     then bold     else id)
             . (if s ^. currentlyInverted then inverted else id)
  let doc :: Doc
      doc = styled (string str)
  currentLine %= (.|. doc)

putLn :: Teletype ()
putLn = Teletype $ do
  s <- get
  previousLines %= (.-. (s ^. currentLine))
  currentLine .= empty

putStringLn :: String -> Teletype ()
putStringLn s = putString s >> putLn


data Attr = Bold | Inverted

attributeLens :: Attr -> Lens' TeletypeState Bool
attributeLens Bold     = currentlyBold
attributeLens Inverted = currentlyInverted

setAttributeTo :: Attr -> Bool -> Teletype ()
setAttributeTo attr value = Teletype $ do
  attributeLens attr .= value

setAttribute :: Attr -> Teletype ()
setAttribute = flip setAttributeTo True

resetAttribute :: Attr -> Teletype ()
resetAttribute = flip setAttributeTo False
















































































































































































































































































































type Terminal a = forall m. Term.MonadTerminal m => m a
type Attribute = forall m. Term.MonadTerminal m => Term.Attribute m

runTerminal :: Terminal a -> IO a
runTerminal = Term.withTerminal . Term.runTerminalT

--

data Doc = Doc
  { width  :: Int
  , height :: Int
  , draw   :: Terminal ()  -- leaves the cursor where it started
  }

putDocLn :: Doc -> Terminal ()
putDocLn doc = do
  replicateM_ (height doc) $ do
    liftIO $ Prelude.putStrLn ""
  Term.moveCursorUp   (height doc)
  draw doc
  Term.moveCursorDown (height doc)


empty :: Doc
empty = Doc 0 0 (pure ())

string :: String -> Doc
string name = Doc (length name) 1 $ do
  Term.putString name
  Term.moveCursorBackward (length name)


attribute :: Attribute
          -> Doc -> Doc
attribute attr doc = doc
  { draw = do Term.setAttribute attr
              draw doc
              Term.resetAttribute attr
  }

bold, inverted :: Doc -> Doc
bold     = attribute Term.bold
inverted = attribute Term.inverted

(.|.) :: Doc -> Doc -> Doc
doc1 .|. doc2 = Doc
  { width  = width doc1 + width doc2
  , height = max (height doc1) (height doc2)
  , draw   = do draw doc1
                Term.moveCursorForward  (width doc1)
                draw doc2
                Term.moveCursorBackward (width doc1)
  }

(.-.) :: Doc -> Doc -> Doc
doc1 .-. doc2 = Doc
  { width  = max (width doc1) (width doc2)
  , height = height doc1 + height doc2
  , draw   = do draw doc1
                Term.moveCursorDown (height doc1)
                draw doc2
                Term.moveCursorUp   (height doc1)
  }

hcat :: [Doc] -> Doc
hcat = foldr (.|.) empty

vcat :: [Doc] -> Doc
vcat = foldr (.-.) empty

--

previousLines :: Lens' TeletypeState Doc
previousLines = lens _previousLines (\s a -> s { _previousLines = a })

currentLine :: Lens' TeletypeState Doc
currentLine = lens _currentLine (\s a -> s { _currentLine = a })

currentlyBold :: Lens' TeletypeState Bool
currentlyBold = lens _currentlyBold (\s a -> s { _currentlyBold = a })

currentlyInverted :: Lens' TeletypeState Bool
currentlyInverted = lens _currentlyInverted (\s a -> s { _currentlyInverted = a })
