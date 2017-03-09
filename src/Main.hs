

type Func a b = a -> b

(.) :: (a -> b) -> (b -> c) -> (a -> c)
(.) f g x = f (g x)
--             ^ ^
--             | |
--             | expected: b
--             | actual:   a
--             |
--           b -> c










































main :: IO ()
main = putStrLn "done."
