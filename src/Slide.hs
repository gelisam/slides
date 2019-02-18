module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Data.Foldable; import Data.Maybe; import qualified Data.Text as Text; import qualified Graphics.UI.FLTK.LowLevel.Ask as Ask; import qualified Graphics.UI.FLTK.LowLevel.FL as FL

data Stmt = PutStrLn String
          | GetLine                                                                                                    deriving Show



-- >>> evalUI helloWorldList
-- >>> evalUI manyNumbersList
evalUI :: [Stmt] -> IO ()
evalUI stmts = do
  xs <- execStateT (mapM go stmts) []
  unless (xs == []) $ do
    flMessage (unlines xs)
  where
    go :: ( MonadIO m
          , MonadState [String] m
          )
       => Stmt -> m ()
    go (PutStrLn s) = modify (++ [s])
    go GetLine      = do xs <- get
                         put []
                         void $ liftIO $ flInput (unlines xs)































































































isPutStrLn :: Stmt -> Bool
isPutStrLn (PutStrLn _) = True
isPutStrLn _            = False


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


flMessage :: String -> IO ()
flMessage = Ask.flMessage . Text.pack

flInput :: String -> IO String
flInput = fmap (Text.unpack . fromJust) . Ask.flInput . Text.pack


main :: IO ()
main = do
  evalUI helloWorldList
  evalUI manyNumbersList
