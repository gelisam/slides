module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable

data Stmt = PutStrLn String
          | GetLine                                                                                                    deriving Show


-- |
-- >>> evalPure helloWorldList  []
-- Just ["hello","world"]
-- >>> evalPure manyNumbersList []
-- Just ["1","2","3","4","5"]
evalPure :: [Stmt] -> [String] -> Maybe [String]
evalPure = evalStateT . execWriterT . mapM go
  where
    go :: ( MonadFail            m
          , MonadState  [String] m
          , MonadWriter [String] m
          )
       => Stmt -> m ()
    go (PutStrLn s) = sendOutput s
    go GetLine      = void nextInput

































































































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
