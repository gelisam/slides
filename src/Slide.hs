{-# LANGUAGE DeriveFunctor, FlexibleContexts, FlexibleInstances, FunctionalDependencies, GADTs, GeneralizedNewtypeDeriving, InstanceSigs, LambdaCase, MultiParamTypeClasses, NumericUnderscores, RankNTypes, RecordWildCards, RecursiveDo, ScopedTypeVariables, TupleSections, TypeApplications, TypeFamilies, UndecidableInstances #-}
module Main where
import qualified System.Terminal as Term                                                                                                   ; import Control.Monad; import Control.Monad.IO.Class

empty :: Doc
string :: String -> Doc

bold, inverted :: Doc -> Doc

(.|.) :: Doc -> Doc -> Doc
(.-.) :: Doc -> Doc -> Doc

hcat :: [Doc] -> Doc
vcat :: [Doc] -> Doc

--

channel :: Bool -> String -> Doc
channel True  = inverted . string
channel False = string

username :: String -> Doc
username = bold . string

message :: String -> String -> Doc
message user msg = (username user .|. string ": " .|. string firstLine)
               .-. wrappedLines rest
  where
    remainingWidth = 20 - length user - length ": "
    (firstLine, rest) = splitAt remainingWidth msg

    wrappedLines :: String -> Doc
    wrappedLines "" = empty
    wrappedLines s  = string (take 20 s)
                  .-. wrappedLines (drop 20 s)

chat :: [String] -> String -> [(String, String)] -> Doc
chat channels currentChannel messages
    = vcat (fmap channelToDoc channels)
  .|. string "  "
  .|. vcat (fmap (uncurry message) messages)
  where
    channelToDoc channelName = channel (channelName == currentChannel)
                                       channelName

interface :: Doc
interface = chat ["general", "random"] "general"
                 [ ("human",   "hello echobot, how are you?")
                 , ("echobot", "hello echobot, how are you?")
                 ]




































































































main :: IO ()
main = runTerminal $ do
  liftIO $ putStrLn ""
  putDocLn interface
  liftIO $ putStrLn ""


data Doc = Doc
  { width  :: Int
  , height :: Int
  , draw   :: Terminal ()  -- leaves the cursor where it started
  }


empty = Doc 0 0 (pure ())

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

bold     = attribute Term.bold
inverted = attribute Term.inverted

doc1 .|. doc2 = Doc
  { width  = width doc1 + width doc2
  , height = max (height doc1) (height doc2)
  , draw   = do draw doc1
                Term.moveCursorForward  (width doc1)
                draw doc2
                Term.moveCursorBackward (width doc1)
  }

doc1 .-. doc2 = Doc
  { width  = max (width doc1) (width doc2)
  , height = height doc1 + height doc2
  , draw   = do draw doc1
                Term.moveCursorDown (height doc1)
                draw doc2
                Term.moveCursorUp   (height doc1)
  }

hcat = foldr (.|.) empty

vcat = foldr (.-.) empty


putDocLn :: Doc -> Terminal ()
putDocLn doc = do
  replicateM_ (height doc) $ do
    liftIO $ putStrLn ""
  Term.moveCursorUp   (height doc)
  draw doc
  Term.moveCursorDown (height doc)












































































































type Terminal a = forall m. Term.MonadTerminal m => m a
type Attribute = forall m. Term.MonadTerminal m => Term.Attribute m

runTerminal :: Terminal a -> IO a
runTerminal = Term.withTerminal . Term.runTerminalT
