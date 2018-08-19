module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Codec.Picture; import Control.Applicative; import Control.Lens; import Data.Array; import Graphics.Gloss; import Graphics.Gloss.Interface.IO.Game; import Graphics.Gloss.Juicy; import System.Process


type DiscreteImage = Array (Int,Int) RGB

type Plane a = (Float,Float) -> a
type ContinuousImage = Plane RGB
type Shape           = Plane Bool

circleC :: Float -> Shape
circleC r = \(x,y) -> x*x + y*y < r*r

blackShape :: Shape -> ContinuousImage
blackShape f = \(x,y) -> if f (x,y) then blackRGB else whiteRGB













































































type RGB = PixelRGBA8

blackRGB, whiteRGB :: RGB
(blackRGB, whiteRGB) = (PixelRGBA8 0 0 0 255, PixelRGBA8 255 255 255 255)

translateC :: (Float, Float) -> ContinuousImage -> ContinuousImage
translateC (dx, dy) f = \(x, y) -> f (x - dx, y - dy)

scaleC :: (Float, Float) -> ContinuousImage -> ContinuousImage
scaleC (sx, sy) f = \(x, y) -> f (x / sx, y / sy)


windowWidth, windowHeight :: Int
(windowWidth, windowHeight) = (640, 480)

discretizeImage :: ContinuousImage -> Picture
discretizeImage f = fromImageRGBA8 $ generateImage f' windowWidth windowHeight
  where
    f' :: Int -> Int -> RGB
    f' x y = f (         fromIntegral x - (fromIntegral windowWidth  / 2)
               , negate (fromIntegral y - (fromIntegral windowHeight / 2))
               )


continuousImage :: ContinuousImage
continuousImage = blackShape (circleC 100)


data Camera = Camera
  { _cameraX    :: Float
  , _cameraY    :: Float
  , _cameraZoom :: Float
  }
  deriving Show
makeLenses ''Camera

initialCamera :: Camera
initialCamera = Camera 0 0 1


data Keyboard = Keyboard
  { _keyboardQ :: KeyState
  , _keyboardW :: KeyState
  , _keyboardE :: KeyState
  , _keyboardA :: KeyState
  , _keyboardS :: KeyState
  , _keyboardD :: KeyState
  }
  deriving Show
makeLenses ''Keyboard

initialKeyboard :: Keyboard
initialKeyboard = Keyboard Up Up Up Up Up Up


data World = World
  { _worldCamera   :: Camera
  , _worldKeyboard :: Keyboard
  }
  deriving Show
makeLenses ''World

initialWorld :: World
initialWorld = World initialCamera initialKeyboard


draw :: Camera -> Picture
draw (Camera {..}) = discretizeImage
                   $ scaleC (_cameraZoom, _cameraZoom)
                   $ translateC (-_cameraX, -_cameraY)
                   $ continuousImage

onEvent :: Event -> Keyboard -> Keyboard
onEvent (EventKey (Char key) keyState _ _) = onKey key keyState
onEvent _ = id

onKey :: Char -> KeyState -> Keyboard -> Keyboard
onKey 'q' keyState = keyboardQ .~ keyState
onKey 'w' keyState = keyboardW .~ keyState
onKey 'e' keyState = keyboardE .~ keyState
onKey 'a' keyState = keyboardA .~ keyState
onKey 's' keyState = keyboardS .~ keyState
onKey 'd' keyState = keyboardD .~ keyState
onKey _ _ = id

-- pixels/s
movingSpeed :: Float
movingSpeed = 100

zoomingSpeed :: Float
zoomingSpeed = 2

onTimeDelta :: Float -> World -> World
onTimeDelta dt world = whenDown keyboardQ (cameraZoom //~ zoomingSpeed ** dt)
                     . whenDown keyboardW (cameraY +~ dt * adjustedMovingSpeed)
                     . whenDown keyboardE (cameraZoom *~  zoomingSpeed ** dt)
                     . whenDown keyboardA (cameraX -~ dt * adjustedMovingSpeed)
                     . whenDown keyboardS (cameraY -~ dt * adjustedMovingSpeed)
                     . whenDown keyboardD (cameraX +~ dt * adjustedMovingSpeed)
                     $ world
  where
    adjustedMovingSpeed = movingSpeed / world ^. worldCamera . cameraZoom

    whenDown :: Getter Keyboard KeyState
             -> (Camera -> Camera)
             -> (World -> World)
    whenDown keyboardKey f
      | world ^. worldKeyboard . keyboardKey == Down
      = worldCamera %~ f
      | otherwise
      = id

test :: IO ()
test = putStrLn "typechecks."

main :: IO ()
main = play (InWindow "gloss" (windowWidth, windowHeight) (800, 0))
            white
            30
            initialWorld
            (\world -> draw $ world ^. worldCamera)
            (\event -> worldKeyboard %~ onEvent event)
            onTimeDelta
