
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

implicit val rectangularShape: Shape[Rectangle] = new Shape[Rectangle] {
  val area: Rectangle => Double = rectangleArea
}

implicit val circularShape: Shape[Circle] = new Shape[Circle] {
  val area: Circle => Double = circleArea
}


case class RichShape[A](
  shape: A,
  isShape: Shape[A]
) {
  def area: Double =
    isShape.area(shape)
}

implicit def toRichShape[A](
  shape: A
)(implicit
  isShape: Shape[A]
): RichShape[A] =
  RichShape(shape, isShape)


// >>> isAreaTooLarge(Rectangle(100,100))
// true
// >>> isAreaTooLarge(Circle(50))
// false
def isAreaTooLarge[A](
  shape: A
)(implicit
  isShape: Shape[A]
): Boolean =
  shape.area > 9000
















































































