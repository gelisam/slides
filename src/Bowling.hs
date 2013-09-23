bonusScore :: Frame -> [Frame] -> [Pins] -> Score
bonusScore f fs b = sum bonusThrows
  where
    bonusThrows = take (bonusBalls f) ts
    ts = concatMap throws fs ++ b  -- less expensive
                                   -- than it looks!

-- concat [[1,2],...] ++ ...
-- [1,2] ++ ...
-- take 2 [1,2,...]
-- laziness!


-- also:
parseFrames :: String -> [Frame]
parseFrames xs = take 10 (go xs)  -- exploiting laziness
  where                           -- to skip bonus balls!
    go ('X'  :xs) = Strike                  : go xs
    go (x:'/':xs) = Spare (pins x)          : go xs
    go (x:x' :xs) = Miss (pins x) (pins x') : go xs














































