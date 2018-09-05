module Slide where
import Test.DocTest                                                                                                                                                                                     ; import Control.Applicative; import Data.IORef

-- |
-- >>> :{
-- do inputs <- fromList
--            [ Just (Color "Red"),  Just (Click 1), Just (Click 2)
--            , Just (Color "Blue"), Just (Click 3), Just (Click 4)
--            ]
--    outputs <- transform inputs
--    mapM_ print =<< takeS 6 outputs
-- :}
-- Nothing
-- Nothing
-- Just (Segment "Red" (1,2))
-- Nothing
-- Nothing
-- Just (Segment "Blue" (3,4))
transform :: Signal (Maybe Event) -> IO (Signal (Maybe Segment))
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


data Signal a = Signal
  { signalHead :: a
  , signalTail :: Memoized (Signal a)
  }


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
test = doctest ["-XLambdaCase", "-XScopedTypeVariables", "src/Slide.hs"]

main :: IO ()
main = putStrLn "typechecks."
