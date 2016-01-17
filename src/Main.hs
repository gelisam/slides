import Control.DeepSeq
import Control.Exception
import GHC.Conc
import System.IO.Unsafe

main :: IO ()
main = do
    print $ head' xs1  -- Left (...)
    print $ head' xs2  -- *** Exception
  where
    xs1 = []          :: [Int]
    xs2 = [1 `div` 0] :: [Int]

head' :: NFData a
      => [a] -> Either SomeException a
head' = unexceptional1 head

unexceptional1 :: NFData a
               => (a -> b)
               -> (a -> Either SomeException b)
unexceptional1 f x = force x `pseq` unexceptional (f x)





































































































unexceptional :: a -> Either SomeException a
unexceptional x = unsafePerformIO $ do
    try (x `seq` return x)


