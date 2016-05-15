
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

class ChildList[A](impl: List[A]) extends MyList[A](impl) {
  override def map[B](
    f: A => B
  )
  : ChildList[B] =
    new ChildList[B](impl.map(f))
  
  override def toString: String =
    s"ChildList(${impl})"
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

// MyList[X] <: Mappable[X, MyList]
// ChildList[X] <: Mappable[X, MyList]
// ChildList[X] <: Mappable[X, ChildList]
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
println(processIterable(new ChildList(List("hello", "world"))))
println(processIterable(MySet(Set("hello", "world"))))


























































































