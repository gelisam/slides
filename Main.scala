  /////////////////////
 // active patterns //
/////////////////////


case class Vector(x: Double, y: Double)

object Polar {
  def unapply(vector: Vector) =
    Some((Math.atan2(vector.y, vector.x),
          Math.sqrt(vector.x * vector.x + vector.y * vector.y)))
}

val point = Vector(3, 4)
val Polar(angle, magnitude) = point





























































































