

type Back b a = a -> b

(.) :: Back c b -> Back b a -> Back c a
(.) f g x = f (g x)

(>>>) :: Back b a -> Back c b -> Back c a
(>>>) = flip (.)















































main :: IO ()
main = putStrLn "done."
