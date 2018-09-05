module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Data.IORef

data Signal a = Signal
  { signalHead :: a
  , signalTail :: Memoized (Signal a)
  }

fromList :: [a] -> IO (Signal a)
takeS    :: Int -> Signal a -> IO [a]

fmapS  :: (a -> b) -> Signal a -> IO (Signal b)
pureS  :: a -> IO (Signal a)
applyS :: Signal (a -> b) -> Signal a -> IO (Signal b)
scanS  :: (a -> b -> a) -> a -> Signal (Maybe b) -> IO (Signal a)





































































newtype Memoized a = Memoized
  { unMemoized :: IORef (Either a (IO a))
  }


fromList = undefined
takeS    = undefined

fmapS  = undefined
pureS  = undefined
applyS = undefined
scanS  = undefined


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
