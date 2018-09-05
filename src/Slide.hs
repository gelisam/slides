module Slide where
import Test.DocTest                                                                                                                                                                                     ; import Control.Applicative; import Control.Concurrent.Chan; import System.IO.Unsafe

data DiscreteApp state = DiscreteApp
  { initialState :: IO state
  , handleEvent  :: state -> Event -> IO state
  , render       :: state -> IO Image }

data MyState = MyState
  { inputChannel :: Chan (Maybe Event)
  , outputSignal :: Signal Image }

toApp :: (Signal (Maybe Event) -> Signal Image)
      -> DiscreteApp MyState
toApp f = DiscreteApp
  { initialState = do
      chan <- newChan
      inputs <- fromChan chan
      let outputs = f inputs
      pure $ MyState chan outputs
  , handleEvent = \(MyState chan outputs) event -> do
      writeChan chan (Just event)
      pure $ MyState chan (signalTail outputs)
  , render = pure . signalHead . outputSignal
  }










































































transform :: Signal (Maybe Event) -> Signal (Maybe Segment)
transform events = outputs
  where
    colorPicks :: Signal (Maybe String)
    colorPicks = mapMaybeS f events
      where
        f (Color x) = Just x
        f _ = Nothing

    numberPicks :: Signal (Maybe Int)
    numberPicks = mapMaybeS f events
      where
        f (Click x) = Just x
        f _ = Nothing

    currentColor :: Signal String
    currentColor = lastS "" colorPicks

    outputs :: Signal (Maybe Segment)
    outputs = liftA2 Segment
          <$> (Just <$> currentColor)
          <*> pairS numberPicks

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
type Image = String


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


test :: IO ()
test = do
  let app = toApp (fmap show . transform)
  state0 <- initialState app
  let loop _     []             = pure ()
      loop state (event:events) = do
        state' <- handleEvent app state event
        output <- render app state
        putStrLn output
        loop state' events
  loop state0 [Color "Red", Click 1, Click 2, Color "Blue", Click 3, Click 4]

main :: IO ()
main = putStrLn "typechecks."
