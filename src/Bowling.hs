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
data Frame = Strike | Spare | Miss

throws :: Frame -> [Pins]
throws Strike = [10]
throws Spare  = [5,5]
throws Miss   = [0,0]






































































