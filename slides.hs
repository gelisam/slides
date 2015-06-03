-- minimax
{-# LANGUAGE ScopedTypeVariables #-}

import Data.List
import Data.Ord


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
    best | maximizer = maximumBy (comparing value)
    
    availableStates :: [gameState]
    availableStates = nextMoves currentState































































































main :: IO ()
main = putStrLn "typechecks."
