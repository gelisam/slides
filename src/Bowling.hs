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




newtype Pins  = Pins  Int  -- number of pins knocked
newtype Balls = Balls Int  -- number of balls thrown
newtype Score = Score Int

pins :: Char -> Pins
pins 'X' = Pins 10
pins '-' = Pins 0
pins  x  = Pins (read [x])










































































