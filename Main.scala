  /////////////////////
 // active patterns //
/////////////////////


case class Vector(x: Double, y: Double)

def manhattan_distance(vector: Vector): Double =
  if (vector.x >= 0 && vector.y >= 0)
    vector.x + vector.y
  else if (vector.x < 0 && vector.y >= 0)
    -vector.x + vector.y
  else if (vector.x >= 0 && vector.y < 0)
    vector.x - vector.y
  else
    -vector.x - vector.y





























































































