import Control.Category

class Category k => Arrow k where
  arr   :: (a -> b) -> k a b
  first :: k a b    -> k (a,r) (b,r)



--    +- a -+                                    +- a -+
--    |     |                                    |     |
--    |     |                                    |     |
--    +- b -+             +---- (a, a') ----+    +- b -+
--    +- b -+             | +- a -++- a' -+ |           +- a' -+
--    |     |             | |     ||      | |           |      |
--    |     |             | |     ||      | |           |      |
--    +- c -+             | +- b -++- b' -+ |           +- b' -+
--           +- a' -+     | +- b -++- b' -+ |    +- b -+
--           |      |     | |     ||      | |    |     |
--           |      |     | |     ||      | |    |     |
--           +- b' -+     | +- c -++- c' -+ |    +- c -+
--           +- b' -+     +---- (c, c') ----+           +- b' -+
--           |      |                                   |      |
--           |      |                                   |      |
--           +- c' -+                                   +- c' -+















(>>>) = undefined
(***) = undefined



























main :: IO ()
main = putStrLn "done."
