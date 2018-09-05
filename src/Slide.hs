module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Data.IORef

data Signal a = Signal
  { signalHead :: a
  , signalTail :: Memoized (Signal a)
  }

fromList :: [a] -> Signal a
takeS    :: Int -> Signal a -> [a]

fmap   :: (a -> b) -> Signal a -> Signal b
pure   :: a -> Signal a
(<*>)  :: Signal (a -> b) -> Signal a -> Signal b
scanS  :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a





































































newtype Memoized a = Memoized
  { unMemoized :: IORef (Either a (IO a))
  }


fromList = undefined
takeS    = undefined

fmap  = undefined
pure  = undefined
(<*>) = undefined
scanS = undefined


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
