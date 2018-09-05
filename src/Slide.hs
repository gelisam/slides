module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Data.IORef

data Signal a = Signal
  { signalHead :: a
  , signalTail :: Memoized (Signal a)
  }


fromList :: [a] -> IO (Signal a)
fromList = undefined

takeS :: Int -> Signal a -> IO [a]
takeS = undefined


fmapS :: (a -> b) -> Signal a -> IO (Signal b)
fmapS f (Signal x memo_xs) = undefined

pureS :: a -> IO (Signal a)
pureS x = undefined

applyS :: Signal (a -> b) -> Signal a -> IO (Signal b)
applyS (Signal f memo_fs) (Signal x memo_xs) = undefined

scanS :: (a -> b -> a) -> a -> Signal (Maybe b) -> IO (Signal a)
scanS f x signal = undefined





































































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


-- |
-- >>> oneTwoThree <- fromList [1,2,3::Int]
-- >>> takeS 3 =<< fmapS (+10) oneTwoThree
-- [11,12,13]
-- >>> oneTwoThreePlus <- fmapS (+) oneTwoThree
-- >>> ten <- pureS (10::Int)
-- >>> takeS 3 =<< applyS oneTwoThreePlus ten
-- [11,12,13]
-- >>> oneTwentyThreeHundred <- fromList [Just 1,Nothing,Just 20,Just 300]
-- >>> takeS 5 =<< scanS (+) 0 oneTwentyThreeHundred
-- [0,1,1,21,321]
test :: IO ()
test = doctest ["-XLambdaCase", "src/Slide.hs"]

main :: IO ()
main = putStrLn "typechecks."
