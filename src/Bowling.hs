frameScore :: [Pins] -> Frame -> [Frame] -> Score
frameScore b f fs = sum (throws f)
                  + bonusScore f fs b

totalScore :: [Pins] -> [Frame] -> Score
totalScore b = sum . mapcons (frameScore b)

-- Haskell oddity: argument order influences program length!








































