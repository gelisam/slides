
trait Mappable[A, L[_]] {
  def map[B](
    f: A => B
  )
  : L[B]
}

case class MyList[A](impl: List[A]) extends Mappable[A, MyList] {
  def map[B](
    f: A => B
  )
  : MyList[B] =
    MyList(impl.map(f))
}

case class MySet[A](impl: Set[A]) extends Mappable[A, MySet] {
  def map[B](
    f: A => B
  )
  : MySet[B] =
    MySet(impl.map(f))
}


def processString(string: String): Int =
  string.length

def processIterable[
  L[X] <: Mappable[X, L]
](
  strings: L[String]
)
: L[Int] =
  strings.map { string =>
    processString(string)
  }.map { x =>
    x + 1
  }

println(processString("hello")) // hello!
println(processIterable(MyList(List("hello", "world"))))
println(processIterable(MySet(Set("hello", "world"))))


























































































