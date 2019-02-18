module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

data Stmt = PutStrLn String
          | GetLine                                                                                                    deriving Show

helloInputList :: [Stmt]
helloInputList = [ PutStrLn "What is your name?"
                 , GetLine
                 , PutStrLn ("Hello, " ++ name) -- "name" not in scope!
                 ]

manyInputsList :: [Stmt]
manyInputsList = execWriter $ do
  tell [PutStrLn "How many numbers?"]
  n <- read <$> tell [GetLine]                  -- tell doesn't return a String!
  tell [PutStrLn ("Enter " ++ show n ++ " numbers:")]
  xs <- replicateM n (read <$> tell [GetLine])  -- tell doesn't return a String!
  tell [PutStrLn ("Their sum is " ++ show (sum xs))]































































































main :: IO ()
main = doctest ["src/Slide.hs"]
