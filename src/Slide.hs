module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Debug.Trace

data Signal a = Signal
  { signalHead :: a
  , signalTail :: () -> Signal a
  }














































































test :: IO ()
test = doctest ["src/Slide.hs"]

main :: IO ()
main = putStrLn "typechecks."
