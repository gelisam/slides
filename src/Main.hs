{-@ div' :: Int -> {v: Int | v != 0 } -> Int @-}
div' = div

doMath :: Int -> IO ()
doMath n = print $ (42 `div'` n) + 1

main :: IO ()
main = doMath 0  -- compile-time error!


































































































