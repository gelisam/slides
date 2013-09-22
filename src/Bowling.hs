frameScore :: Frame -> [Frame] -> [Pins] -> Score
frameScore f fs b = sum (throws f)
                  + bonusScore f fs b

totalScore :: [Pins] -> [Frame] -> Score
totalScore b = sum . mapcons (\x xs -> frameScore x xs b)

-- Haskell oddity: argument order influences program length!








































