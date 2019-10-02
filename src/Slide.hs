--------------------------------------------------------------------------------
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                            * Mixing                                        --
--                            * Multiple Styles                               --
--                            * in the Same Haskell Program                   --
--                            > * terminal rendering API                      --
--                              * messages API                                --
--                              * chatbot API                                 --
--                              * UI                                          --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--                                                                            --
--------------------------------------------------------------------------------





































{-# LANGUAGE DeriveFunctor, FlexibleContexts, FlexibleInstances, FunctionalDependencies, GADTs, GeneralizedNewtypeDeriving, InstanceSigs, LambdaCase, MultiParamTypeClasses, NumericUnderscores, RankNTypes, RecordWildCards, RecursiveDo, ScopedTypeVariables, TupleSections, TypeApplications, TypeFamilies, UndecidableInstances #-}
module Main where
import qualified System.Terminal as Term                                                                                                   ; import Control.Monad; import Control.Monad.IO.Class


putChannel :: Bool -> String -> Terminal ()
putChannel active name = do
  when active $ Term.setAttribute Term.inverted
  Term.putString name
  when active $ Term.resetAttribute Term.inverted

putUsername :: String -> Terminal ()
putUsername name = do
  Term.setAttribute Term.bold
  Term.putString name
  Term.resetAttribute Term.bold

putMessage :: String -> String -> Terminal ()
putMessage user msg = do
  putUsername user
  Term.putString ": "
  Term.putString msg

main :: IO ()
main = runTerminal $ do
  -- clear out some space for drawing
  replicateM_ 4 $ do
    liftIO $ putStrLn ""

  Term.moveCursorUp 3
  putChannel True "general"

  Term.moveCursorDown 1
  Term.setCursorColumn 0
  putChannel False "random"

  Term.moveCursorUp 1
  Term.setCursorColumn 9
  putMessage "human" "hello"

  Term.moveCursorDown 1
  Term.setCursorColumn 9
  putMessage "echobot" "hello"

  Term.moveCursorDown 3
  Term.setCursorColumn 0


































































































type Terminal a = forall m. Term.MonadTerminal m => m a

runTerminal :: Terminal a -> IO a
runTerminal = Term.withTerminal . Term.runTerminalT
