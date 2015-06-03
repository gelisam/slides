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
  deriving (Eq)

instance Show Cell where
    show X = "X"
    show O = "O"
    show Empty = " "

printBoard :: Board -> IO ()
printBoard b = do
    print (b ! (1,1), b ! (2,1), b ! (3,1))
    print (b ! (1,2), b ! (2,2), b ! (3,2))
    print (b ! (1,3), b ! (2,3), b ! (3,3))

-- |
-- >>> printBoard emptyBoard
-- ( , , )
-- ( , , )
-- ( , , )
-- >>> printBoard $ emptyBoard // [((1,1), X)]
-- (X, , )
-- ( , , )
-- ( , , )
emptyBoard :: Board
emptyBoard = listArray ((1,1), (3,3)) (repeat Empty)


isXWin :: Board -> Bool
isXWin b = threeInARow b O
        || threeInAColumn b X
        || threeInADiagonal b X

isOWin :: Board -> Bool
isOWin b = threeInARow b X
        || threeInAColumn b O
        || threeInADiagonal b O

-- isDraw :: Board -> Bool





threeInARow :: Board -> Cell -> Bool
threeInARow b c = flip any [1..3] $ \j ->
                  flip all [1..3] $ \i ->
                  b ! (i,j) == c

threeInAColumn :: Board -> Cell -> Bool
threeInAColumn b c = flip any [1..3] $ \i ->
                     flip all [1..3] $ \j ->
                     b ! (i,j) == c

threeInADiagonal :: Board -> Cell -> Bool
threeInADiagonal b c = flip all [1..3] (\i -> b ! (i,  i) == c)
                    || flip all [1..3] (\i -> b ! (i,4-i) == c)


-- values :: Array GameState Double































































































main :: IO ()
main = putStrLn "typechecks."
