
case class Rectangle(
  width: Double,
  height: Double
)

case class Circle(
  radius: Double
)


def rectangleArea(rectangle: Rectangle): Double =
  rectangle.width * rectangle.height

def circleArea(circle: Circle): Double =
  scala.math.Pi * Math.pow(circle.radius, 2)
















































































