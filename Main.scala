  /////////////////////
 // active patterns //
/////////////////////


case class Vector(x: Double, y: Double)

object Polar {
  def angle(vector: Vector) = Math.atan2(vector.y, vector.x)
  def magnitude(vector: Vector) =
    Math.sqrt(vector.x * vector.x + vector.y * vector.y)
}

val point = Vector(3, 4)
val angle = Polar.angle(point)
val magnitude = Polar.magnitude(point)





























































































