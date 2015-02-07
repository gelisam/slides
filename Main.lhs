
> import Prelude hiding ((!!))

  Unsafe (!!):









> (!!) :: [a] -> Int -> a
> []     !! _ = error "index too large"
> (x:_ ) !! 0 = x
> (_:xs) !! i = xs !! (i-1)




































































> main :: IO ()
> main = putStrLn "typechecks."
