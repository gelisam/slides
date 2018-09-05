module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Codec.Picture; import Control.Applicative; import Control.Lens; import Data.Array; import Graphics.Gloss; import Graphics.Gloss.Interface.IO.Game; import Graphics.Gloss.Juicy; import System.Process


type DiscreteImage = Array (Int,Int) RGB















































































type RGB = PixelRGBA8
type ContinuousImage = (Float,Float) -> RGB

blackRGB, whiteRGB :: RGB
(blackRGB, whiteRGB) = (PixelRGBA8 0 0 0 255, PixelRGBA8 255 255 255 255)

circleC :: Float -> ContinuousImage
circleC r (x,y) = if x*x + y*y < r*r then blackRGB else whiteRGB


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
continuousImage = circleC 100


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
draw (Camera {..}) = scale _cameraZoom _cameraZoom
                   $ translate (-_cameraX) (-_cameraY)
                   $ discretizeImage
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
test = do
  _ <- system "stack build && write-your-own-frp"
  putStrLn "done."

main :: IO ()
main = play (InWindow "gloss" (windowWidth, windowHeight) (800, 0))
            white
            30
            initialWorld
            (\world -> draw $ world ^. worldCamera)
            (\event -> worldKeyboard %~ onEvent event)
            onTimeDelta
