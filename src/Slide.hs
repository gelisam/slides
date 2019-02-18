module Slide where

--               1
--          ____/|\____
--        /      |      \
--       2       3       4
--     _/|\_     |
--   /   |   \   |
--  5    6    7  8
data Rose a = Node a [Rose a]


--               *
--          ____/|\____
--        /      |      \
--       *       *       4
--     _/|\_     |
--   /   |   \   |
--  5    6    7  8
data Roser a = Leaf a | Noder (String -> Roser a)
























































































main :: IO ()
main = putStrLn "typechecks."
