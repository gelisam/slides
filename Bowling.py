
def totalScore(frames, bonusRolls):
  if len(frames) == 0:
    return 0
  else:
    x,xs = frames[0],frames[1:]
    #                     .-------- this xs makes the recursion weird
    return frameScore(x, xs, bonusRolls) + totalScore(xs, bonusRolls)
