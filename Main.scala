  /////////////////////
 // active patterns //
/////////////////////


case class Vector(x: Double, y: Double)


sealed trait Cardinal
case class NorthEast(dx: Double, dy: Double) extends Cardinal
case class SouthEast(dx: Double, dy: Double) extends Cardinal
case class SouthWest(dx: Double, dy: Double) extends Cardinal
case class NorthWest(dx: Double, dy: Double) extends Cardinal

object Cardinal {
  def apply(vector: Vector): Cardinal = ???
}


def manhattan_distance(vector: Vector): Double =
  Cardinal(vector) match {
    // warning: match is not exhaustive, case NorthEast() is missing
    case SouthEast(dx, dy) => dx + dy
    case SouthWest(dx, dy) => dx + dy
    case NorthWest(dx, dy) => dx + dy
  }





























































































