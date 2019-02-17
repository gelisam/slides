module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

-- helloInputAST = '(do (bind name (flInput "What is your name?"))
--
--                      (flMessage  (mappend "Hello, " name)))
helloInputUI :: IO ()
helloInputUI = do name <- flInput "What is your name?"
                  flMessage ("Hello, " ++ name)



-- manyInputsAST = '(do (fmap read (flInput "How many numbers?"))
--                      (bind x (fmap read
--                                (flInput (mappend "Enter "
--                                           (mappend (show n) " numbers:")))))
--                      (bind xs (replicateM (subtract n 1)
--                                 (fmap read (flInput ""))))
--                      (flMessage  (mappend "Their sum is "
--                                    (show (sum (cons x xs))))))
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
main = doctest ["src/Slide.hs"]
