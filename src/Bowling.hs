frameScore :: [Pins] -> Frame -> [Frame] -> Score
frameScore b f fs = sum (throws f)
                  + bonusScore f fs b

totalScore :: [Pins] -> [Frame] -> Score
totalScore b = sum . mapcons (\f -> frameScore b f)

-- Haskell oddity: argument order influences program length!








































