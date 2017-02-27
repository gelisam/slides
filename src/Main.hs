import Control.Category

class Category k => Arrow k where
  arr   :: (a -> b) -> k a b
  first :: k a b    -> k (a,r) (b,r)





--                       +- a -++- (a', a'') -+
--                       |     ||             |
--                       |     ||             |
--                       +- b -++- (b', b'') -+
--                       +-- (b, (b', b'')) --+
--                       |                    |
--                       |        arr         |
--                       |                    |
--                       +-- ((b, b'), b'') --+
--                       +- (b, b') -++- b'' -+
--                       |           ||       |
--                       |           ||       |
--                       +- (c, c') -++- c'' -+













(>>>) = undefined
(***) = undefined



























main :: IO ()
main = putStrLn "done."
