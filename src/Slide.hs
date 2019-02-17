module Slide where
import Test.DocTest                                                                                                    ; import Control.Monad; import Control.Monad.Fail; import Control.Monad.State; import Control.Monad.Writer; import Text.Read (readMaybe)

-- helloInputAST = '(do (sendOutput "What is your name?")
--                      (bind name nextInput)
--                      (sendOutput (mappend "Hello, " name)))
helloInputPure :: [String] -> Maybe [String]
helloInputPure = evalStateT $ execWriterT $ do
  sendOutput "What is your name?"
  name <- nextInput
  sendOutput ("Hello, " ++ name)

-- manyInputsAST = '(do (sendOutput "How many numbers?")
--                      (bind n (fmap read nextInput))
--                      (sendOutput (mappend "Enter "
--                                    (mappend (show n) " numbers:")))
--                      (bind xs (replicateM n (fmap read nextInput)))
--                      (sendOutput (mappend "Their sum is " (show (sum xs)))))
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
