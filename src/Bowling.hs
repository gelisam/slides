frameScore :: Frame -> [Frame] -> [Pins] -> Score
frameScore f fs b = sum (throws f)
                  + bonusScore f fs b

totalScore :: [Frame] -> [Pins] -> Score
totalScore fs b = sum $ mapcons (\x xs -> frameScore x xs b) fs

-- Haskell oddity: argument order influences program length!








































