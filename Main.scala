
class MyList:
  def __init__(self, elems):
    self.impl = list(elems)
  
  def map(self, f):
    return MyList(map(f, self.impl))
  
  def __str__(self):
    return str(self.impl)

class MySet:
  def __init__(self, elems):
    self.impl = set(elems)
  
  def map(self, f):
    return MySet(map(f, self.impl))
  
  def __str__(self):
    return str(self.impl)


def processString(string):
  return len(string)

def processMany(strings):
  return strings.map(processString)




print processString("hello")  # 5
print processMany(MyList(["hello", "world"]))  # [5, 5]
print processMany(MySet(["hello", "world"]))  # set([5])

























































































