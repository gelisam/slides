import Control.Category

class Category k => Arrow k where
  arr   :: (a -> b) -> k a b
  first :: k a b    -> k (a,r) (b,r)

-- 2D composition using Arrow
(>>>) :: Arrow k => k a b -> k b c -> k a c
(***) :: Arrow k => k a b -> k a' b' -> k (a,a') (b,b')


--                        +---- (a, a') ----+
--                        | +- a -++- a' -+ |
--                        | |     ||      | |
--                        | |     ||      | |
--                        | +- b -++- b' -+ |
--                        | +- b -++- b' -+ |
--                        | |     ||      | |
--                        | |     ||      | |
--                        | +- c -++- c' -+ |
--                        +---- (c, c') ----+















(>>>) = undefined
(***) = undefined



























main :: IO ()
main = putStrLn "done."
