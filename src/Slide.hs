module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Codec.Picture hiding (Image); import Control.Applicative; import Control.Lens; import Data.Monoid; import Graphics.Gloss; import Graphics.Gloss.Interface.IO.Game; import Graphics.Gloss.Juicy; import System.Process


data DiscreteApp state = DiscreteApp
  { initialState :: state
  , handleEvent  :: state -> Event -> state
  , render       :: state -> Image
  }

data Signal a
type ContinuousApp = Signal (Maybe Event) -> Signal Image

fromDiscreteApp :: DiscreteApp state -> ContinuousApp
fromDiscreteApp (DiscreteApp {..}) = fmap render
                                   . scanS handleEvent initialState


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


instance Functor Signal where
  fmap = undefined

instance Applicative Signal where
  pure  = undefined
  (<*>) = undefined

scanS = undefined


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
