module Slide where
import Test.DocTest                                                                                                                                                                                    ; import Control.Applicative; import Control.DeepSeq; import Control.Monad; import Debug.Trace; import System.IO

--   1---101---202---404---808--> a
--    \ /   \ /   \ /   \ /
--    / \   / \   / \   / \
-- 100---101---202---404---808--> b


--  a
--  |
--  |
--  b 
a, b :: Signal (Maybe Int)
a = Just <$> scanS (+) 1   b
b = Just <$> scanS (+) 100 a









































































verboseAdd :: String -> Int -> Int -> Int
verboseAdd label x y = trace ( "(" ++ label ++ " adds "
                            ++ show x ++ " + " ++ show y ++ ")"
                             )
                     $ x + y

verboseA, verboseB :: Signal (Maybe Int)
verboseA = Just <$> scanS (verboseAdd "a") 1   verboseB
verboseB = Just <$> scanS (verboseAdd "b") 100 verboseA


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


test :: IO ()
test = do
  putStrLn "a:"
  mapM_ (hPutStrLn stderr . show . force) $ takeS 1 verboseA
  replicateM_ 14 $ hPutStrLn stderr ""

main :: IO ()
main = putStrLn "typechecks."
