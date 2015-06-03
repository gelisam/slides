-- minimax
{-# LANGUAGE ScopedTypeVariables #-}


minimax :: forall gameState.
           (gameState -> Double)
        -> (gameState -> [gameState])
        -> Bool
        -> gameState
        -> gameState
minimax value nextMoves maximizer currentState = nextState
  where
    nextState :: gameState
    nextState = best availableStates
    
    best = _
    
    availableStates :: [gameState]
    availableStates = _































































































main :: IO ()
main = putStrLn "typechecks."
