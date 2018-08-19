module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Codec.Picture hiding (Image); import Control.Applicative; import Control.Lens; import Data.Array; import Graphics.Gloss; import Graphics.Gloss.Interface.IO.Game; import Graphics.Gloss.Juicy; import System.Process


type DiscreteAnimation = [Image]

type Animated a = Float -> a
type ContinuousAnimation = Animated Image
type Trajectory          = Animated (Float, Float)

rotating :: Float -> Trajectory
rotating r = \t -> (r * cos t, r * sin t)

moving :: Image -> Trajectory -> ContinuousAnimation
moving image f = \t -> translateC (f t) image









































































type RGB = PixelRGBA8
type ContinuousImage = (Float,Float) -> RGB
type Image = ContinuousImage

translateC :: (Float, Float) -> ContinuousImage -> ContinuousImage
translateC (dx, dy) f = \(x, y) -> f (x - dx, y - dy)

scaleC :: (Float, Float) -> ContinuousImage -> ContinuousImage
scaleC (sx, sy) f = \(x, y) -> f (x / sx, y / sy)

blackRGB, whiteRGB :: RGB
(blackRGB, whiteRGB) = (PixelRGBA8 0 0 0 255, PixelRGBA8 255 255 255 255)

circleC :: Float -> ContinuousImage
circleC r (x,y) = if x*x + y*y < r*r then blackRGB else whiteRGB


windowWidth, windowHeight :: Int
(windowWidth, windowHeight) = (640, 480)

fps :: Float
fps = 30

discretizeImage :: ContinuousImage -> Picture
discretizeImage f = fromImageRGBA8 $ generateImage f' windowWidth windowHeight
  where
    f' :: Int -> Int -> RGB
    f' x y = f (         fromIntegral x - (fromIntegral windowWidth  / 2)
               , negate (fromIntegral y - (fromIntegral windowHeight / 2))
               )


discretizeTime :: Float -> Float
discretizeTime = (/ fps) . fromIntegral . round . (* fps)

continuousAnimation :: Float -> ContinuousImage
continuousAnimation t = translateC ( 100 * cos (-t/2 * 2*pi)
                                   , 100 * sin (-t/2 * 2*pi)
                                   )
                      $ circleC 25


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
  , _worldTime     :: Float
  , _worldSpeed    :: Float
  }
  deriving Show
makeLenses ''World

initialWorld :: World
initialWorld = World initialCamera initialKeyboard 0 1


draw :: World -> Picture
draw world = discretizeImage
           $ scaleC ( world ^. worldCamera . cameraZoom
                    , world ^. worldCamera . cameraZoom
                    )
           $ translateC ( world ^. worldCamera . cameraX . to negate
                        , world ^. worldCamera . cameraY . to negate
                        )
           $ continuousAnimation
           $ world ^. worldTime

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
zoomingSpeed = 3

onTimeDelta :: Float -> World -> World
onTimeDelta dt world = whenDown keyboardQ (worldSpeed //~ zoomingSpeed ** dt)
                     . whenDown keyboardW (worldCamera . cameraY +~ dt * adjustedMovingSpeed)
                     . whenDown keyboardE (worldSpeed *~  zoomingSpeed ** dt)
                     . whenDown keyboardA (worldCamera . cameraX -~ dt * adjustedMovingSpeed)
                     . whenDown keyboardS (worldCamera . cameraY -~ dt * adjustedMovingSpeed)
                     . whenDown keyboardD (worldCamera . cameraX +~ dt * adjustedMovingSpeed)
                     . (worldTime +~ dt * world ^. worldSpeed)
                     $ world
  where
    adjustedMovingSpeed = movingSpeed / world ^. worldCamera . cameraZoom

    whenDown :: Getter Keyboard KeyState
             -> (World -> World)
             -> (World -> World)
    whenDown keyboardKey f
      | world ^. worldKeyboard . keyboardKey == Down
      = f
      | otherwise
      = id

test :: IO ()
test = putStrLn "typechecks."

main :: IO ()
main = play (InWindow "gloss" (windowWidth, windowHeight) (800, 0))
            white
            (round fps)
            initialWorld
            draw
            (\event -> worldKeyboard %~ onEvent event)
            onTimeDelta
