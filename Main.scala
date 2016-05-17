
trait Shape {
  def area: Double
}

case class Rectangle(
  width: Double,
  height: Double
) extends Shape {
  def area: Double =
    width * height
}

case class Circle(
  radius: Double
) extends Shape {
  def area: Double =
    scala.math.Pi * Math.pow(radius, 2)
}





def isAreaTooLarge(shape: Shape): Boolean =
  shape.area > 9000
















































































