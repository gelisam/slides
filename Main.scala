
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


trait Shape[A] {
  val area: A => Double
}

val rectangularShape: Shape[Rectangle] = new Shape[Rectangle] {
  val area: Rectangle => Double = rectangleArea
}

val circularShape: Shape[Circle] = new Shape[Circle] {
  val area: Circle => Double = circleArea
}


// >>> isAreaTooLarge(Rectangle(100,100), rectangularShape)
// true
// >>> isAreaTooLarge(Circle(50), circularShape)
// false
def isAreaTooLarge[A](
  shape: A,
  isShape: Shape[A]
): Boolean =
  isShape.area(shape) > 9000
















































































