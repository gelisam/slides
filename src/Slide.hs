module Slide where
import Test.DocTest                                                                                                                                                                                     ; import Control.Applicative; import Data.IORef

fromList :: [a] -> Signal a

data DiscreteApp state = DiscreteApp
  { initialState :: state
  , handleEvent  :: state -> Event -> state
  , render       :: state -> Image
  }

toApp :: (Signal (Maybe Event) -> Signal Image)
      -> DiscreteApp MyState
toApp f = undefined










































































data Event
data Image
data MyState


data Signal a

fromList = undefined


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
