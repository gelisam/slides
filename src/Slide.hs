module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Control.Applicative; import Control.DeepSeq; import Data.Maybe; import Debug.Trace; import System.IO

--   numbers
--      |
--      a
--    /   \
--   b     c
--    \   /
--      d
numbers :: Signal (Maybe Int)
numbers = Just <$> fromList [1..]

a :: Signal (Maybe Int)
a = mapMaybeS isEven numbers

b :: Signal Int
b = fromMaybe 0 <$> a

c :: Signal Int
c = fromMaybe 0 <$> a

d :: Signal Int
d = (+) <$> b <*> c












































































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

mapMaybeS :: (a -> Maybe b) -> Signal (Maybe a) -> Signal (Maybe b)
mapMaybeS f = fmap (>>= f)

isEven :: Int -> Maybe Int
isEven x = trace ( "(is " ++ show x ++ " even? "
                ++ if even x then "yes.)" else "no.)"
                 )
         $ if even x then Just x else Nothing


test :: IO ()
test = do
  hPutStrLn stderr "d:"
  mapM_ (hPutStrLn stderr . show . force) $ takeS 6 d

main :: IO ()
main = putStrLn "typechecks."
