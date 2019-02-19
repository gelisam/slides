module Slide where
import Test.DocTest                                                                                                    ; import Data.Foldable; import Control.Monad.Writer

data Stmt = PutStrLn String
          | GetLine                                                                                                    deriving Show

helloWorldList :: [Stmt]
helloWorldList = [ PutStrLn "hello"
                 , PutStrLn "world"
                 ]

-- |
-- >>> manyNumbersList
-- [PutStrLn "1",PutStrLn "2",PutStrLn "3",PutStrLn "4",PutStrLn "5"]
manyNumbersList :: [Stmt]
manyNumbersList = execWriter $ do
  for_ [1..5] $ \i -> do
    tell [PutStrLn (show i)]



































































































main :: IO ()
main = doctest ["src/Slide.hs"]
