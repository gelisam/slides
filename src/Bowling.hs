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

-- |
-- >>> pins 'X'
-- 10
-- >>> pins '9'
-- 9
-- >>> pins '-'
-- 0
pins :: Char -> Int  -- imprecise types
pins 'X' = 10
pins '-' = 0
pins  x  = read [x]










































































