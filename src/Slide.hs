module Slide where
import Test.DocTest                                                                                                                                                                                     ; import Control.Applicative; import Data.IORef

fromList :: [a] -> IO (Signal a)

data DiscreteApp state = DiscreteApp
  { initialState :: IO state
  , handleEvent  :: state -> Event -> IO state
  , render       :: state -> IO Image
  }

toApp :: (Signal (Maybe Event) -> IO (Signal Image))
      -> DiscreteApp MyState
toApp f = undefined










































































data Event
data Image
data MyState


data Signal a = Signal
  { signalHead :: a
  , signalTail :: Memoized (Signal a)
  }


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
test = main

main :: IO ()
main = putStrLn "typechecks."
