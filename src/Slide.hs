{-# LANGUAGE DeriveFunctor, FlexibleContexts, FlexibleInstances, FunctionalDependencies, GADTs, GeneralizedNewtypeDeriving, InstanceSigs, LambdaCase, MultiParamTypeClasses, NumericUnderscores, RankNTypes, RecordWildCards, RecursiveDo, ScopedTypeVariables, TupleSections, TypeApplications, TypeFamilies, UndecidableInstances #-}
module Main where
import qualified System.Terminal as Term                                                                                                   ; import Control.Monad; import Control.Monad.IO.Class; import Prelude

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





































































































channel :: Bool -> String -> Doc
channel True  = inverted . string
channel False = string

username :: String -> Doc
username = bold . string

message :: String -> String -> Doc
message user msg = username user .|. string ": " .|. string msg

chat :: [String] -> String -> [(String, String)] -> Doc
chat channels currentChannel messages
    = vcat (fmap channelToDoc channels)
  .|. string "  "
  .|. vcat (fmap (uncurry message) messages)
  where
    channelToDoc channelName = channel (channelName == currentChannel)
                                       channelName

main :: IO ()
main = runTerminal $ do
  liftIO $ Prelude.putStrLn ""
  putDocLn $ chat ["general", "random"] "general"
                  [ ("human", "hello")
                  , ("echobot", "hello")
                  ]
  liftIO $ Prelude.putStrLn ""













































































































type Terminal a = forall m. Term.MonadTerminal m => m a
type Attribute = forall m. Term.MonadTerminal m => Term.Attribute m

runTerminal :: Terminal a -> IO a
runTerminal = Term.withTerminal . Term.runTerminalT
