

type Func a b = a -> b

(.) :: (b -> c) -> (a -> b) -> (a -> c)
(.) f g x = f (g x)

(>>>) :: (a -> b) -> (b -> c) -> (a -> c)
(>>>) = flip (.)















































main :: IO ()
main = putStrLn "done."
