module Slide where
import Test.DocTest                                                                                                                                                                                     ; import Control.Applicative; import Control.Concurrent.Chan; import Data.IORef

data DiscreteApp state = DiscreteApp
  { initialState :: IO state
  , handleEvent  :: state -> Event -> IO state
  , render       :: state -> IO Image }

data MyState = MyState
  { inputChannel :: Chan (Maybe Event)
  , outputSignal :: Memoized (Signal Image) }

toApp :: (Signal (Maybe Event) -> IO (Signal Image))
      -> DiscreteApp MyState
toApp f = DiscreteApp
  { initialState = do
      chan <- newChan
      memo_inputs <- fromChan chan
      memo_outputs <- memoize $ f =<< runMemoized memo_inputs
      pure (MyState chan memo_outputs)
  , handleEvent = \(MyState chan memo_outputs) event -> do
      writeChan chan (Just event)
      Signal _ memo_outputs' <- runMemoized memo_outputs
      pure (MyState chan memo_outputs')
  , render = fmap signalHead . runMemoized . outputSignal
  }










































































data Event = Color String | Click Int
data Segment = Segment String (Int,Int)
  deriving Show
type Image = String


transform :: Signal (Maybe Event) -> IO (Signal (Maybe Segment))
transform events = do
  colorPicks :: Signal (Maybe String)
             <- let f (Color x) = Just x
                    f _ = Nothing
                in mapMaybeS f events

  numberPicks :: Signal (Maybe Int)
              <- let f (Click x) = Just x
                     f _ = Nothing
                 in mapMaybeS f events

  currentColor :: Signal String
               <- lastS "" colorPicks

  outputs :: Signal (Maybe Segment)
          <- do
    fs <- fmapS (liftA2 Segment . Just) currentColor
    xs <- pairS numberPicks
    applyS fs xs

  pure outputs

mapMaybeS :: (a -> Maybe b) -> Signal (Maybe a) -> IO (Signal (Maybe b))
mapMaybeS f = fmapS (>>= f)

lastS :: a -> Signal (Maybe a) -> IO (Signal a)
lastS = scanS (curry snd)

pairS :: forall a. Signal (Maybe a) -> IO (Signal (Maybe (a,a)))
pairS inputs = do
  let toggle :: Maybe a -> a -> Maybe a
      toggle Nothing  x = Just x
      toggle (Just _) _ = Nothing
  prevs :: Signal (Maybe a)
        <- scanS toggle Nothing inputs
  fs <- fmapS (liftA2 (,)) prevs
  applyS fs inputs


data Signal a = Signal
  { signalHead :: a
  , signalTail :: Memoized (Signal a)
  }


fromChan :: Chan a -> IO (Memoized (Signal a))
fromChan chan = memoize $ do
  x <- readChan chan
  memo_xs <- fromChan chan
  pure (Signal x memo_xs)

fromList :: [a] -> IO (Signal a)
fromList []  = error "fromList: empty list"
fromList [x] = fromList [x,x]
fromList (x:xs) = do
  memo_xs <- memoize (fromList xs)
  pure (Signal x memo_xs)

takeS :: Int -> Signal a -> IO [a]
takeS 0 _ = pure []
takeS 1 (Signal x memo_xs) = pure [x]
takeS n (Signal x memo_xs) = do
  xs <- runMemoized memo_xs
  (x:) <$> takeS (n-1) xs


fmapS :: (a -> b) -> Signal a -> IO (Signal b)
fmapS f (Signal x memo_xs) = do
  let y = f x
  memo_ys <- memoize $ do
    xs <- runMemoized memo_xs
    fmapS f xs
  pure (Signal y memo_ys)

pureS :: a -> IO (Signal a)
pureS x = do
  memo_xs <- memoize (pureS x)
  pure (Signal x memo_xs)

applyS :: Signal (a -> b) -> Signal a -> IO (Signal b)
applyS (Signal f memo_fs) (Signal x memo_xs) = do
  let y = f x
  memo_ys <- memoize $ do
    fs <- runMemoized memo_fs
    xs <- runMemoized memo_xs
    applyS fs xs
  pure (Signal y memo_ys)

scanS :: (a -> b -> a) -> a -> Signal (Maybe b) -> IO (Signal a)
scanS f x signal = do
  memo_xs <- memoize $ do
    let x' = case signalHead signal of
               Nothing -> x
               Just y  -> f x y
    signal' <- runMemoized (signalTail signal)
    scanS f x' signal'
  pure (Signal x memo_xs)


newtype Memoized a = Memoized
  { unMemoized :: IORef (Either a (IO a))
  }

memoize :: IO a -> IO (Memoized a)
memoize action = Memoized <$> newIORef (Right action)

runMemoized :: Memoized a -> IO a
runMemoized (Memoized ref) = readIORef ref >>= \case
  Left x -> pure x
  Right action -> do
    x <- action
    writeIORef ref (Left x)
    pure x


test :: IO ()
test = do
  let app = toApp $ \inputs -> do
        outputs <- transform inputs
        fmapS show outputs
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
