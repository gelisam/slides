-- minimax
{-# LANGUAGE ScopedTypeVariables #-}

import Data.Array
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


type Board = Array (Int,Int) Cell
data Cell = X | O | Empty

emptyBoard :: Board
emptyBoard = listArray ((1,1), (3,3)) (repeat Empty)

-- isXWin :: Board -> Bool
-- isOWin :: Board -> Bool
-- isDraw :: Board -> Bool

-- values :: Array GameState Double































































































main :: IO ()
main = putStrLn "typechecks."
