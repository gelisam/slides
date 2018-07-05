module Slide where





--             listSource [1..]
--                             \
--                              \
--                               zipWith max
--                              /           \
--                             /             \
-- listSource [2..] --- stutter               \
--                                             zipWith (+) --- printAll
--  listSource [1,3..]                        /
--                    \                      /
--                     \                    /
--                      alternate --- take 4
--                     /
--                    /
--  listSource [2,4..]

































































































main :: IO ()
main = putStrLn "typechecks."
