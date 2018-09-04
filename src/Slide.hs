module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Data.IORef

data Signal a = Signal
  { signalHead :: a
  , signalTail :: () -> Signal a
  }






































































newtype Memoized a = Memoized
  { unMemoized :: IORef (Either a (IO a))
  }


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
