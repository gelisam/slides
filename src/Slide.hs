module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Codec.Picture hiding (Image); import Control.Applicative; import Control.Lens; import Data.Monoid; import Graphics.Gloss; import Graphics.Gloss.Interface.IO.Game; import Graphics.Gloss.Juicy; import System.Process


data DiscreteApp state = DiscreteApp
  { initialState :: state
  , handleEvent  :: state -> Event -> state
  , render       :: state -> Image
  }

data Signal a
type ContinuousApp = Signal (Maybe Event) -> Signal Image

fmap :: (a -> b) -> Signal a -> Signal b

pure  :: a -> Signal a
(<*>) :: Signal (a -> b) -> Signal a -> Signal b

-- |
-- >>> scanl (+) 0 [1,20,300]
-- [0,1,21,321]
scanS :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a





































































data RGB
data Array i a

type ContinuousImage = (Float,Float) -> RGB
type Image = ContinuousImage

textC :: String -> ContinuousImage
textC = undefined

type Animated a = Float -> a
type ContinuousAnimation = Animated ContinuousImage

fmap  = undefined
pure  = undefined
(<*>) = undefined
scanS = undefined


test :: IO ()
test = doctest ["src/Slide.hs"]

main :: IO ()
main = putStrLn "typechecks."
