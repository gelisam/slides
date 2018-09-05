module Slide where
import Test.DocTest                                                                                                                                                                                     ; import Control.Applicative

transform :: [Event] -> [Segment]
transform = go "" Nothing
  where
    go :: String -> Maybe Int -> [Event] -> [Segment]
    go _     _        []                     = []
    go _     _        (Color color : events) = go color Nothing  events
    go color Nothing  (Click x     : events) = go color (Just x) events
    go color (Just x) (Click y     : events) = Segment color (x,y)
                                             : go color Nothing events

transformS :: Signal (Maybe Event) -> Signal (Maybe Segment)
transformS events = outputs
  where
    colorPicks   = mapMaybeS isColor events
    numberPicks  = mapMaybeS isClick events
    currentColor = lastS "" colorPicks
    outputs      = liftA2 Segment
               <$> (Just <$> currentColor)
               <*> pairS numberPicks



isColor :: Event -> Maybe String
isColor (Color x) = Just x
isColor _ = Nothing

isClick :: Event -> Maybe Int
isClick (Click x) = Just x
isClick _ = Nothing

mapMaybeS :: (a -> Maybe b) -> Signal (Maybe a) -> Signal (Maybe b)
mapMaybeS f = fmap (>>= f)

lastS :: a -> Signal (Maybe a) -> Signal a
lastS = scanS (curry snd)

pairS :: forall a. Signal (Maybe a) -> Signal (Maybe (a,a))
pairS inputs = liftA2 (,) <$> prevs <*> inputs
  where
    toggle :: Maybe a -> a -> Maybe a
    toggle Nothing  x = Just x
    toggle (Just _) _ = Nothing

    prevs :: Signal (Maybe a)
    prevs = scanS toggle Nothing inputs












































































data Event = Color String | Click Int
data Segment = Segment String (Int,Int)
  deriving Show


data Signal a = Signal
  { signalHead :: a
  , signalTail :: Signal a
  }
  deriving Show

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


test :: IO ()
test = main

main :: IO ()
main = putStrLn "typechecks."
