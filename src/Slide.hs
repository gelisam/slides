module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

data Stmt = PutStrLn String
          | GetLine {- binds a String -}                                                                             deriving Show

      --------------------------------------------------------------
      --                                                          --
      --               PutStrLn s1                                --
      --                    |                                     --
      --                 GetLine      -- binds x1                 --
      --                    |                                     --
      --               PutStrLn s2    -- x1 is in scope           --
      --                    |                                     --
      --               PutStrLn s3    -- x1 is in scope           --
      --                    |                                     --
      --                 GetLine      -- binds x2                 --
      --                    |                                     --
      --               PutStrLn s4    -- x1 and x2 are in scopy   --
      --                    |                                     --
      --                   Nil                                    --
      --                                                          --
      --                                                          --
      --------------------------------------------------------------































































































main :: IO ()
main = doctest ["src/Slide.hs"]
