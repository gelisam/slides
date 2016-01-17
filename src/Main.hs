import Data.Maybe

main :: IO ()
main = do
    print $ head'' xs1  -- Left (...)
    print $ head'' xs2  -- *** Exception
  where
    xs1 = [1 `div'` 0] :: [Maybe Int]
    xs2 = []           :: [Maybe Int]

head' :: [a] -> Maybe a
head' []    = Nothing
head' (x:_) = Just x

head'' :: [a] -> a
head'' = fromJust . head'

div' :: Integral a => a -> a -> Maybe a
div' _ 0 = Nothing
div' x y = Just (x `div` y)






































































































