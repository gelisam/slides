{-@ tail' :: {xs: [a] | length xs > 0 } -> [a] @-}
tail' = tail

main :: IO ()
main = print $ tail' (tail' [1])  -- compile-time error!




































































































