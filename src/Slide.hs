module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable

data Stmt = PutStrLn String
          | GetLine                                                                                                    deriving Show

-- |
-- >>> evalIO helloWorldList
-- hello
-- world
-- >>> evalIO manyNumbersList
-- 1
-- 2
-- 3
-- 4
-- 5
evalIO :: [Stmt] -> IO ()
evalIO = mapM_ go
  where
    go :: Stmt -> IO ()
    go (PutStrLn s) = putStrLn s
    go GetLine      = void getLine


































































































helloWorldList :: [Stmt]
helloWorldList = [ PutStrLn "hello"
                 , PutStrLn "world"
                 ]

manyNumbersList :: [Stmt]
manyNumbersList = execWriter $ do
  for_ [1..5] $ \i -> do
    tell [PutStrLn (show i)]


sendOutput :: MonadWriter [String] m => String -> m ()
sendOutput s = tell [s]

nextInput :: (MonadFail m, MonadState [String] m) => m String
nextInput = do
  (s:ss) <- get
  put ss
  pure s


main :: IO ()
main = doctest ["-XFlexibleContexts", "src/Slide.hs"]
