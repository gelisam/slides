
def totalScore(frames, bonusRolls):
  return sum(map(lambda x: frameScore(x, bonusRolls), frames))
