
trait Mappable[A, L_A] {
  def map[B](
    f: A => A
  )
  : L_A
}

case class MyList[A](impl: List[A]) extends Mappable[A, MyList[A]] {
  def map[B](
    f: A => A
  )
  : MyList[B] =
    MyList(impl.map(f))
}

//class ChildList[A](impl: List[A]) extends MyList[A](impl) {
//  override def map[B](
//    f: A => B
//  )
//  : ChildList[B] =
//    new ChildList[B](impl.map(f))
//}
//
//case class MySet[A](impl: Set[A]) extends Mappable[A, MySet[A]] {
//  def map[B](
//    f: A => B
//  )
//  : MySet[B] =
//    MySet(impl.map(f))
//}


def processString(string: String): String =
  string + "!"

def processIterable[
  L[X] <: Mappable[X, L[X]]
](
  strings: L[String]
)
: L[Int] =
  strings.map { string =>
    processString(string)
  }

println(processString("hello")) // hello!
println(processIterable(MyList(List("hello", "world"))))
//println(processIterable(new ChildList(List("hello", "world"))))
//println(processIterable(MySet(Set("hello", "world"))))


























































































