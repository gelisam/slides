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















































