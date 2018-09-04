module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Data.IORef; import Debug.Trace

-- |
-- >>> lazyInt <- memoize $ \() -> trace "evaluating" (2+2::Int)
-- >>> runMemoized lazyInt
-- evaluating
-- 4
-- >>> runMemoized lazyInt
-- 4
newtype Memoized a = Memoized
  { unMemoized :: IORef (Either a (() -> a))
  }




































































data Event = Color String | Click Int
  deriving Show
data Segment = Segment String (Int,Int)
  deriving Show


data Signal a = Signal
  { signalHead :: a
  , signalTail :: () -> Signal a
  }

fromList :: [a] -> Signal a
fromList []     = error "fromList: empty list"
fromList [x]    = Signal x (\() -> fromList [x])
fromList (x:xs) = Signal x (\() -> fromList xs)

takeS :: Int -> Signal a -> [a]
takeS 0 _             = []
takeS n (Signal x xs) = x : takeS (n-1) (xs ())

instance Functor Signal where
  fmap f (Signal x xs) = Signal (f x) (fmap (fmap f) xs)

instance Applicative Signal where
  pure x = fromList [x]
  Signal f fs <*> Signal x xs = Signal (f x) ((<*>) <$> fs <*> xs)

scanS :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a
scanS f x ys = Signal x $ \() -> case signalHead ys of
  Nothing -> scanS f x       $ signalTail ys ()
  Just y  -> scanS f (f x y) $ signalTail ys ()


memoize :: (() -> a) -> IO (Memoized a)
memoize action = Memoized <$> newIORef (Right action)

runMemoized :: Memoized a -> IO a
runMemoized (Memoized ref) = readIORef ref >>= \case
  Left x -> pure x
  Right action -> do
    let x = action ()
    writeIORef ref (Left x)
    pure x


test :: IO ()
test = doctest ["-XLambdaCase", "src/Slide.hs"]

main :: IO ()
main = putStrLn "typechecks."
