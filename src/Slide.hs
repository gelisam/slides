module Slide where
import Test.DocTest                                                                                                                                                                                     ; import Control.Applicative; import Control.Concurrent.Chan; import Data.IORef; import System.Timeout
import System.IO.Unsafe

data Signal a = Signal
  { signalHead :: a
  , signalTail :: Signal a }

-- |
-- >>> chan <- newChan :: IO (Chan String)
-- >>> strings <- fromChan chan
--
-- >>> writeChan chan "foo"
-- >>> signalHead strings
-- "foo"
--
-- >>> writeChan chan "bar"
-- >>> signalHead . signalTail $ strings
-- "bar"
--
-- >>> timeout 1 . print . signalHead . signalTail . signalTail $ strings
-- "Nothing
fromChan :: Chan a -> IO (Signal a)
fromChan chan = unsafeInterleaveIO
              $ Signal <$> readChan chan <*> fromChan chan










































































data Event = Color String | Click Int
data Segment = Segment String (Int,Int)
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
test = doctest ["src/Slide.hs"]

main :: IO ()
main = putStrLn "typechecks."
