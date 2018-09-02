module Slide where
import Test.DocTest                                                                                                                                                                                     ; import Control.Applicative

-- |
-- >>> :{
-- let inputs = fromList
--            [ Just (Color "Red"),  Just (Click 1), Just (Click 2)
--            , Just (Color "Blue"), Just (Click 3), Just (Click 4)
--            ]
--     outputs = transform inputs
-- in mapM_ print (takeS 6 outputs)
-- :}
-- Nothing
-- Nothing
-- Just (Segment "Red" (1,2))
-- Nothing
-- Nothing
-- Just (Segment "Blue" (3,4))
transform :: Signal (Maybe Event) -> Signal (Maybe Segment)
transform events = outputs
  where
    outputs :: Signal (Maybe Segment)
    outputs = undefined


















































































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
test = doctest ["-XScopedTypeVariables", "src/Slide.hs"]

main :: IO ()
main = putStrLn "typechecks."
