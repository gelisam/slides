-- fromList :: [a] -> Signal a
-- takeS    :: Int -> Signal a -> [a]
--
-- fmap     :: (a -> b) -> Signal a -> Signal b
-- pure     :: a -> Signal a
-- (<*>)    :: Signal (a -> b) -> Signal a -> Signal b
-- scanS    :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a
--
-- >>> fmap (+10) [1,2,3,..]                            -->  [11,12,13,..]
-- >>> (+) <$> [1,2,3,..] <*> pure 10                   -->  [11,12,13,..]
-- >>> scanl (+) 0 [Just 1,Nothing,Just 20,Just 300,..] -->  [0,1,1,21,321,..]
module Slide where
import Test.DocTest

data Signal a = Signal
  { signalHead :: a
  , signalTail :: Signal a
  }

fromList :: [a] -> Signal a
fromList = undefined

takeS :: Int -> Signal a -> [a]
takeS = undefined

instance Functor Signal where
  fmap :: (a -> b) -> Signal a -> Signal b
  fmap = undefined

instance Applicative Signal where
  pure :: a -> Signal a
  pure = undefined

  (<*>) :: Signal (a -> b) -> Signal a -> Signal b
  (<*>) = undefined

scanS :: (a -> b -> a) -> a -> Signal (Maybe b) -> Signal a
scanS = undefined























































































-- |
-- >>> takeS 3 $ fmap (+10) (fromList [1,2,3])
-- [11,12,13]
-- >>> takeS 3 $ (+) <$> fromList [1,2,3] <*> pure 10
-- [11,12,13]
-- >>> takeS 5 $ scanS (+) 0 (fromList [Just 1,Nothing,Just 20,Just 300])
-- [0,1,1,21,321]
test :: IO ()
test = doctest ["-XInstanceSigs", "src/Slide.hs"]

main :: IO ()
main = putStrLn "typechecks."
