
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


def isRectangleTooLarge(rectangle: Rectangle): Boolean =
  rectangleArea(rectangle) > 9000

def isCircleTooLarge(circle: Circle): Boolean =
  circleArea(circle) > 9000


def isAreaTooLarge[A](
  shape: A
): Boolean =
  shape.area > 9000 // method area not found
















































































