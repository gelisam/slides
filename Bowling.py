
def totalScore(frames, bonusRolls):
  return sum(mapcons(lambda x xs: frameScore(x, xs, bonusRolls), frames))






def mapcons(f, list):
  if len(list) == 0:
    return []
  else:
    x,xs = list[0],list[1:]
    return [f(x,xs)] + map(f, xs)
