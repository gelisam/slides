
trait Mappable[A, L[_]] {
  def map(
    f: A => A
  )
  : L[A]
}

case class MyList[A](impl: List[A]) extends Mappable[A, MyList] {
  def map(
    f: A => A
  )
  : MyList[A] =
    MyList(impl.map(f))
}

case class MySet[A](impl: Set[A]) extends Mappable[A, MySet] {
  def map(
    f: A => A
  )
  : MySet[A] =
    MySet(impl.map(f))
}


def processString(string: String): String =
  string + "!"

def processIterable[
  L[X] <: Mappable[X, L]
](
  strings: L[String]
)
: L[String] =
  strings.map { string =>
    processString(string)
  }.map { x =>
    x + "!"
  }

println(processString("hello")) // hello!
println(processIterable(MyList(List("hello", "world"))))
println(processIterable(MySet(Set("hello", "world"))))


























































































