
trait Mappable[A] {
  def map[B](
    f: A => B
  )
  : Mappable[B]
}

case class MyList[A](impl: List[A]) extends Mappable[A] {
  def map[B](
    f: A => B
  )
  : MyList[B] =
    MyList(impl.map(f))
}

case class MySet[A](impl: Set[A]) extends Mappable[A] {
  def map[B](
    f: A => B
  )
  : MySet[B] =
    MySet(impl.map(f))
}


def processString(string: String): Int =
  string.length

def processIterable[
  L[X] <: Mappable[X]
](
  strings: L[String]
)
: Mappable[Int] =
  strings.map { string =>
    processString(string)
  }

println(processString("hello")) // hello!
println(processIterable(MyList(List("hello", "world"))))
println(processIterable(MySet(Set("hello", "world"))))


























































































