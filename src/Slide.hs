module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Text.Read (readMaybe)

-- |
-- >>> helloInputPure ["Sam"]
-- Just ["What is your name?","Hello, Sam"]
-- >>> helloInputPure []
-- Nothing
helloInputPure :: [String] -> Maybe [String]
helloInputPure = evalStateT $ execWriterT $ do
  sendOutput "What is your name?"
  name <- nextInput
  sendOutput ("Hello, " ++ name)

-- |
-- >>> manyInputsPure ["2","100","200"]
-- Just ["How many numbers?","Enter 2 numbers:","Their sum is 300"]
manyInputsPure :: [String] -> Maybe [String]
manyInputsPure = evalStateT $ execWriterT $ do
  sendOutput "How many numbers?"
  n <- read <$> nextInput
  sendOutput ("Enter " ++ show n ++ " numbers:")
  xs <- replicateM n (read <$> nextInput)
  sendOutput ("Their sum is " ++ show (sum xs))

































































































sendOutput :: MonadWriter [String] m => String -> m ()
sendOutput s = tell [s]

nextInput :: (MonadFail m, MonadState [String] m) => m String
nextInput = do
  (s:ss) <- get
  put ss
  pure s

main :: IO ()
main = doctest ["-XFlexibleContexts", "src/Slide.hs"]
