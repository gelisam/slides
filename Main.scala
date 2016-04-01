  /////////////////////
 // active patterns //
/////////////////////


case class Vector(x: Double, y: Double)

object NorthEast {...}
object SouthEast {...}
object SouthWest {...}
object NorthWest {...}

def manhattan_distance(vector: Vector): Double =
  vector match {
    case NorthEast(dx, dy) => dx + dy
    case SouthEast(dx, dy) => dx + dy
    case SouthWest(dx, dy) => dx + dy
    case NorthWest(dx, dy) => dx + dy
  }





























































































