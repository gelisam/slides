{-# LANGUAGE ScopedTypeVariables #-}
import Control.Monad
import Data.Map (Map, (!))
import qualified Data.Map as Map


type Graph node = Map node [node]

dfs :: forall node. (Show node, Ord node)
    => node
    -> Graph node
    -> Map node Int
dfs node0 g = go node0 Map.empty
  where
    go :: node -> Map node Int -> Map node Int
    go node visited = case Map.lookup node visited of
      Just _  -> visited
      Nothing ->
        let i        = Map.size visited
            visited' = Map.insert node i visited
            neighbours = case Map.lookup node g of
              Just nodes -> nodes
              Nothing    -> error "invalid graph"
        in foldr go visited' neighbours

--  / \
-- |   |
--  `->a <--> b
--     ^      |
--     |      v
--     d <--> c<-.
--            |   |
--             \ /
main :: IO ()
main = print
     $ Map.toList
     $ dfs "a"
     $ Map.fromList [ ("a", ["a", "b"])
                    , ("b", ["a", "e"]) -- programmer
                    , ("c", ["c", "d"]) -- error!
                    , ("d", ["a", "c"])
                    ]
                     




































































































