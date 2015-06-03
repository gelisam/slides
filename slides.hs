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
         | otherwise = minimumBy (comparing value)
    
    availableStates :: [gameState]
    availableStates = nextMoves currentState


xWins :: Double
xWins = 1000

oWins :: Double
oWins = -1000

draw :: Double
draw = 0

-- values :: Array GameState Double































































































main :: IO ()
main = putStrLn "typechecks."
