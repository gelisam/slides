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
    
    best :: [gameState] -> gameState
    best | maximizer = maximum _
    
    availableStates :: [gameState]
    availableStates = nextMoves currentState































































































main :: IO ()
main = putStrLn "typechecks."
