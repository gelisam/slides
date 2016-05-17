
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


// >>> isAreaTooLarge(Rectangle(100,100), rectangleArea)
// true
// >>> isAreaTooLarge(Circle(50), circleArea)
// false
def isAreaTooLarge[A](
  shape: A,
  area: A => Double
): Boolean =
  area(shape) > 9000
















































































