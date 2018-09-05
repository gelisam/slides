module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Codec.Picture hiding (Image); import Control.Applicative; import Control.Lens; import Data.Monoid; import Graphics.Gloss; import Graphics.Gloss.Interface.IO.Game; import Graphics.Gloss.Juicy; import System.Process; import Control.Concurrent.Chan; import System.IO.Unsafe; import Data.IORef

type ContinuousApp = Signal (Maybe Event) -> Signal Image


outputs :: Signal Picture
outputs = translate (fromIntegral (-windowWidth) / 2) 0
        . scale 0.3 0.3
        . text
        . show
      <$> events










































































type RGB = PixelRGBA8
type ContinuousImage = (Float,Float) -> RGB
type Image = ContinuousImage
type Animated a = Float -> a
type ContinuousAnimation = Animated Image
type Time = Float


data Signal a = Signal
  { signalHead :: a
  , signalTail :: Signal a
  }

fromChan :: Chan a -> IO (Signal a)
fromChan chan = unsafeInterleaveIO
              $ Signal <$> readChan chan <*> fromChan chan

fromList :: [a] -> Signal a
fromList []     = error "fromList: empty list"
fromList [x]    = Signal x (fromList [x])
fromList (x:xs) = Signal x (fromList xs)

takeS :: Int -> Signal a -> [a]
takeS 0 _             = []
takeS n (Signal x xs) = x : takeS (n-1) xs

instance Functor Signal where
  fmap f (Signal x xs) = Signal (f x) (fmap f xs)

instance Applicative Signal where
  pure x = fromList [x]
  Signal f fs <*> Signal x xs = Signal (f x) (fs <*> xs)

scanS :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a
scanS f x ys = Signal x $ case signalHead ys of
  Nothing -> scanS f x       $ signalTail ys
  Just y  -> scanS f (f x y) $ signalTail ys



windowWidth, windowHeight :: Int
(windowWidth, windowHeight) = (640, 480)

fps :: Float
fps = 30

lineThickness :: Float
lineThickness = 20

mwhen :: Monoid a => Bool -> a -> a
mwhen True  x = x
mwhen False _ = mempty


{-# NOINLINE eventsIORef #-}
eventsIORef :: IORef (Maybe Event)
eventsIORef = unsafePerformIO $ newIORef Nothing

{-# NOINLINE eventsChan #-}
eventsChan :: Chan (Maybe Event)
eventsChan = unsafePerformIO newChan

{-# NOINLINE events #-}
events :: Signal (Maybe Event)
events = unsafePerformIO $ fromChan eventsChan

draw :: Signal Picture -> IO Picture
draw = pure . signalHead

onEvent :: Event -> Signal Picture -> IO (Signal Picture)
onEvent event signal = do
  writeIORef eventsIORef (Just event)
  pure signal

onTimeDelta :: Float -> Signal Picture -> IO (Signal Picture)
onTimeDelta _ signal = do
  event <- readIORef eventsIORef
  writeChan eventsChan event
  writeIORef eventsIORef Nothing
  pure (signalTail signal)

test :: IO ()
test = do
  --doctest ["-XTemplateHaskell", "-XTupleSections", "-XViewPatterns", "src/Slide.hs"]
  _ <- system "stack build && write-your-own-frp"
  putStrLn "done."

main :: IO ()
main = do
  writeChan eventsChan Nothing
  playIO (InWindow "gloss" (windowWidth, windowHeight) (800, 0))
         white
         (round fps)
         outputs
         draw
         onEvent
         onTimeDelta
