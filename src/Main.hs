

type Func a b = a -> b

(.) :: (b -> c) -> (a -> b) -> (a -> c)
(.) f g x = f (g x)


















































main :: IO ()
main = putStrLn "done."
