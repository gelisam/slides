module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Codec.Picture hiding (Image); import Control.Applicative; import Control.Lens; import Data.Monoid; import Graphics.Gloss; import Graphics.Gloss.Interface.IO.Game; import Graphics.Gloss.Juicy; import System.Process


data DiscreteApp state = DiscreteApp
  { initialState :: state
  , handleEvent  :: state -> Event -> state
  , render       :: state -> Image
  }















































































data RGB

type ContinuousImage = (Float,Float) -> RGB
type Image = ContinuousImage

type Animated a = Float -> a
type ContinuousAnimation = Animated Image


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
