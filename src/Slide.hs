module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Codec.Picture hiding (Image); import Control.Applicative; import Control.Lens; import Data.Monoid; import Graphics.Gloss; import Graphics.Gloss.Interface.IO.Game; import Graphics.Gloss.Juicy; import System.Process


data DiscreteApp state = DiscreteApp
  { initialState :: state
  , handleEvent  :: state -> Event -> state
  , render       :: state -> Image
  }

type Animated a = Float -> a
type ContinuousApp = Animated (Maybe Event) -> Animated Image

isClick :: Maybe Event -> Bool

predictClick :: ContinuousApp
predictClick f = \t -> if isClick (f (t + 1.0))
                       then textC "you will click in 1 second"
                       else textC ""

acknowledgeClick :: ContinuousApp
acknowledgeClick f = \t -> if any (isClick . f) [0,0.1..t]
                           then textC "you have clicked!"
                           else textC "you have not clicked yet"











































































data RGB
data Array i a

type ContinuousImage = (Float,Float) -> RGB
type Image = ContinuousImage

isClick = undefined

textC :: String -> ContinuousImage
textC = undefined

type ContinuousAnimation = Animated ContinuousImage


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
