import Control.DeepSeq
import Control.Exception
import GHC.Conc
import System.IO.Unsafe

main :: IO ()
main = do
    print $ head xs1  -- Left (...)
    print $ head xs2  -- *** Exception
  where
    xs1 = [1 `div'` 0] :: [Either SomeException Int]
    xs2 = []           :: [Either SomeException Int]

div' :: (Integral a, NFData a)
     => a -> a -> Either SomeException a
div' = unexceptional2 div

unexceptional2 :: (NFData a, NFData b)
               => (a -> b -> c)
               -> (a -> b -> Either SomeException c)
unexceptional2 f x y = force x
                `pseq` force y
                `pseq` unexceptional (f x y)



































































































unexceptional :: a -> Either SomeException a
unexceptional x = unsafePerformIO $ do
    try (x `seq` return x)

unexceptional1 :: NFData a
               => (a -> b)
               -> (a -> Either SomeException b)
unexceptional1 f x = force x `pseq` unexceptional (f x)


