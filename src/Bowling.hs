-- | http://codingdojo.org/cgi-bin/wiki.pl?KataBowling
module Bowling where


-- |
-- >>> score "XXXXXXXXXXXX"
-- 300
-- >>> score "9-9-9-9-9-9-9-9-9-9-"
-- 90
-- >>> score "5/5/5/5/5/5/5/5/5/5/5"
-- 150
score "XXXXXXXXXXXX"          = 300
score "9-9-9-9-9-9-9-9-9-9-"  = 90
score "5/5/5/5/5/5/5/5/5/5/5" = 150




type Pins  = Int  -- number of pins knocked
type Balls = Int  -- number of balls thrown
type Score = Int

pins :: Char -> Pins
pins 'X' = 10
pins '-' = 0
pins  x  = read [x]

-- "When scoring, "X" indicates a strike,
--                "/" indicates a spare,
--                "-" indicates a miss."
data Frame = Strike | Spare Pins | Miss Pins Pins

throws :: Frame -> [Pins]
throws Strike     = [10]
throws (Spare n)  = [n, 10-n]
throws (Miss n m) = [n, m]

bonusBalls :: Frame -> Balls
bonusBalls Strike    = 2
bonusBalls (Spare _) = 1
bonusBalls _         = 0

bonusScore :: Frame -> [Frame] -> [Pins] -> Score
bonusScore f fs b = sum bonusThrows
  where
    bonusThrows = take (bonusBalls f) ts
    ts = concatMap throws fs ++ b

frameScore :: Frame -> [Frame] -> [Pins] -> Score
frameScore f fs b = sum (throws f)
                  + bonusScore f fs b

mapcons :: (a -> [a] -> b) -> [a] -> [b]
mapcons f []     = []
mapcons f (x:xs) = f x xs : mapcons f xs

totalScore :: [Frame] -> [Pins] -> Score
totalScore fs b = sum $ mapcons (\x xs -> frameScore x xs b) fs










































