module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

data Stmt = PutStrLn String
          | GetLine {- binds a String -}                                                                             deriving Show

      --------------------------------------------------------------
      --                                                          --
      --               PutStrLn s1                                --
      --                    |                                     --
      --                 GetLine                                  --
      --          _________/|\_________                           --
      --        /           |           \                         --
      --       |            |            |                        --
      --       |            |            |                        --
      --  PutStrLn s2  PutStrLn s2  PutStrLn s2                   --
      --       |            |            |                        --
      --      Nil      PutStrLn s3  PutStrLn s3                   --
      --                    |            |                        --
      --                   Nil      PutStrLn s4                   --
      --                                 |                        --
      --                                Nil                       --
      --                                                          --
      --------------------------------------------------------------































































































main :: IO ()
main = doctest ["src/Slide.hs"]
