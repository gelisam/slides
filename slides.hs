-- minimax
{-# LANGUAGE GeneralizedNewtypeDeriving, RecordWildCards, ScopedTypeVariables #-}

import Control.Monad
import Data.Array
import Data.List
import Data.Monoid
import Data.Ord
import Text.Printf


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


type Board = Array (Fin3,Fin3) Cell
data Cell = X | O | Empty
  deriving (Eq, Ord, Bounded, Ix)

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

isDraw :: Board -> Bool
isDraw b = allCellsFull b
        && not (isXWin b)
        && not (isOWin b)


allCellsFull :: Board -> Bool
allCellsFull b = flip all [1..3] $ \i ->
                 flip all [1..3] $ \j ->
                 b ! (i,j) /= Empty

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


data GameState = GameState
  { gameBoard       :: Board
  , activePlayer    :: Bool  -- True for X
  , nbAvailableRows :: Fin3
  } deriving (Show, Eq, Ord, Bounded, Ix)

printGameState :: GameState -> IO ()
printGameState (GameState {..}) = do
    printBoard gameBoard
    printf "%s to play, in the last %d rows if possible.\n"
           (if activePlayer then "X" else "O")
           (getFin3 nbAvailableRows)

values :: Array GameState Double
values = array (minBound, maxBound)
               [(gameState, value gameState) | gameState <- allGameStates]
  where
    allGameStates :: [GameState]
    allGameStates = range (minBound, maxBound)
    
    cachedValue :: GameState -> Double
    cachedValue = (values !)
    
    value :: GameState -> Double
    value g | isXWin (gameBoard g) = xWins
    value g | isOWin (gameBoard g) = oWins
    value g | isDraw (gameBoard g) = draw
    value g = cachedValue $ ai g

nextMoves :: GameState -> [GameState]
nextMoves (GameState {..}) = [gameState ij | ij <- validPositions]
  where
    emptyPositions :: [(Fin3,Fin3)]
    emptyPositions = [(i,j) | i <- [1..3]
                            , j <- [1..3]
                            , gameBoard ! (i,j) == Empty
                            ]
    
    availablePositions :: [(Fin3,Fin3)]
    availablePositions = filter (\(i,j) -> j >= minJ) emptyPositions
    
    validPositions :: [(Fin3,Fin3)]
    validPositions = if null availablePositions
                     then emptyPositions
                     else availablePositions
    
    minJ :: Fin3
    minJ = 4 - nbAvailableRows
    
    gameState :: (Fin3,Fin3) -> GameState
    gameState (i,j) = GameState (gameBoard // [((i,j), activeToken)])
                                (not activePlayer)
                                (remainingRows j)
    
    activeToken :: Cell
    activeToken = if activePlayer then X else O
    
    remainingRows :: Fin3 -> Fin3
    remainingRows 1 = 2
    remainingRows 2 = 1
    remainingRows 3 = 3

ai :: GameState -> GameState
ai g = minimax (values !)
               nextMoves
               (activePlayer g)
               g

initialState :: GameState
initialState = GameState emptyBoard True 3

main :: IO ()
main = display initialState
  where
    display :: GameState -> IO ()
    display g = do printGameState g
                   examine g
    
    examine :: GameState -> IO ()
    examine g | isXWin (gameBoard g) = putStrLn "Congratulations, X!"
              | isOWin (gameBoard g) = putStrLn "Congratulations, O!"
              | isDraw (gameBoard g) = putStrLn "Oh well, it's a draw."
              | otherwise            = play g
    
    play :: GameState -> IO ()
    play = display . ai





















































































instance (Ix i, Bounded i, Bounded a) => Bounded (Array i a) where
    minBound = listArray (minBound, maxBound) (repeat minBound)
    maxBound = listArray (minBound, maxBound) (repeat maxBound)

fromEq :: Eq a => a -> a -> a
fromEq x1 x2 = if x1 == x2 then x1 else error "not equal"

-- A sequence of boxes, one of which is selected.
data SelectedBox = SelectedBox
  { boxCount :: Int
  , selectionIndex :: Int
  }

instance Monoid SelectedBox where
    -- There is only one box, and that box is selected.
    mempty = SelectedBox 1 0
    
    -- Replace all the boxes from the left sequence with a copy of the box
    -- sequence from the right. The box which was selected on the left is
    -- now a sequence of boxes, one of which is selected.
    SelectedBox m i `mappend` SelectedBox n j = SelectedBox (m*n) (i*n+j)

selectBox :: Ix a => (a,a) -> a -> SelectedBox
selectBox b i = SelectedBox (rangeSize b) (index b i)

nestedSelectionIndex :: [SelectedBox] -> Int
nestedSelectionIndex = selectionIndex . mconcat

instance (Ix i, Ix a) => Ix (Array i a) where
    range (xs0, xsZ) = array b <$> do
        forM (range b) $ \i -> do
          x <- range (xs0 ! i, xsZ ! i)
          return (i, x)
      where
        b = fromEq (bounds xs0) (bounds xsZ)
    
    index (xs0, xsZ) xs = nestedSelectionIndex (selectBoxAt <$> range b)
      where
        b = fromEq (bounds xs0) (bounds xsZ)
        selectBoxAt i = selectBox (xs0 ! i, xsZ ! i) (xs ! i)
    
    inRange (xs0, xsZ) xs = all inRangeAt (range b)
      where
        b = fromEq (bounds xs0) (bounds xsZ)
        inRangeAt i = inRange (xs0 ! i, xsZ ! i) (xs ! i)
    
    rangeSize (xs0, xsZ) = product (rangeSizeAt <$> range b)
      where
        b = fromEq (bounds xs0) (bounds xsZ)
        rangeSizeAt i = rangeSize (xs0 ! i, xsZ ! i)



newtype Fin3 = Fin3 { getFin3 :: Int }
  deriving (Show, Eq, Num, Enum, Ord, Ix)

instance Bounded Fin3 where
  minBound = 1
  maxBound = 3
