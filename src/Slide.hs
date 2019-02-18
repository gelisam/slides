module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

helloWorldUI :: IO ()
helloWorldUI = flMessage (unlines ["hello","world"])

manyNumbersUI :: IO ()
manyNumbersUI = flMessage (unlines (fmap show [1..5]))

helloInputUI :: IO ()
helloInputUI = do name <- flInput "What is your name?"
                  flMessage ("Hello, " ++ name)

manyInputsUI :: IO ()
manyInputsUI = do n <- read <$> flInput "How many numbers?"
                  x <- read <$> flInput ("Enter " ++ show n ++ " numbers:")
                  xs <- replicateM (n-1) (read <$> flInput "")
                  flMessage ("Their sum is " ++ show (sum (x:xs)))

































































































flMessage :: String -> IO ()
flMessage = Ask.flMessage . Text.pack

flInput :: String -> IO String
flInput = fmap (Text.unpack . fromJust) . Ask.flInput . Text.pack

main :: IO ()
main = do
  helloWorldUI
  manyNumbersUI
  helloInputUI
  manyInputsUI
