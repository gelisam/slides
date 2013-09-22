
def totalScore(frames, bonusRolls):
  if len(frames) == 0:
    return 0
  else:
    x,xs = frames[0],frames[1:]
    
    return frameScore(x, xs, bonusRolls) + totalScore(xs, bonusRolls)

def map(f, list):
  if len(list) == 0:
    return []
  else:
    x,xs = list[0],list[1:]
    return [f(x)] + map(f, xs)
