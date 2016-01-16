div' :: Int -> Int -> Maybe Int
div' _ 0 = Nothing
div' x y = Just (x `div` y)

doMath :: Int -> IO ()
doMath 0 = putStrLn "please enter another number"
doMath n = do
    case 42 `div'` n of
      Nothing -> error "never happens"
      Just x  -> print (x + 1)

main :: IO ()
main = doMath 0


































































































