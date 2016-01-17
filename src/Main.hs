import Control.Exception
import System.IO.Unsafe



main :: IO ()
main = do
    print $ head' xs1  -- Left (...)
    print $ head' xs2  -- *** Exception
  where
    xs1 = []          :: [Int]
    xs2 = [1 `div` 0] :: [Int]


head' :: [a] -> Either SomeException a
head' xs = unexceptional (head xs)








































































































unexceptional :: a -> Either SomeException a
unexceptional x = unsafePerformIO $ do
    try (x `seq` return x)


