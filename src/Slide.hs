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
data Free f a = Pure a | Deep (f     (Free f a))

data StmtF a = PutStrLnF String a
             | GetLineF (String -> a)






















































































main :: IO ()
main = putStrLn "typechecks."
