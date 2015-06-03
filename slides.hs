-- minimax
{-# LANGUAGE ScopedTypeVariables #-}


minimax ::                  
           (gameState -> Double)
        -> (gameState -> [gameState])
        -> Bool
        -> gameState
        -> gameState
minimax value nextMoves maximizer currentState = nextState
  where

    nextState = _































































































main :: IO ()
main = putStrLn "typechecks."
