
def totalScore(frames, bonusRolls):
  return sum(map(lambda x: frameScore(x, bonusRolls), frames))






def map(f, list):
  if len(list) == 0:
    return []
  else:
    x,xs = list[0],list[1:]
    return [f(x)] + map(f, xs)
