  /////////////////////
 // active patterns //
/////////////////////


case class Vector(x: Double, y: Double)

object Polar {
  def apply(angle: Double, magnitude: Double) =
    Vector(Math.cos(angle) * magnitude,
           Math.sin(angle) * magnitude)
}

val point = Polar(0.9273, 5)
val Vector(px, py) = point





























































































