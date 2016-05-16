trait ChangeElementType[L_A, B, L_B]


trait Mappable[A, +L_A] {
  def map(
    f: A => A
  )
  : L_A
}

case class MyList[A](impl: List[A]) extends Mappable[A, MyList[A]] {
  def map(
    f: A => A
  )
  : MyList[A] =
    MyList(impl.map(f))
}

class ChildList[A](impl: List[A]) extends MyList[A](impl) with Mappable[A, ChildList[A]] {
  override def map(
    f: A => A
  )
  : ChildList[A] =
    new ChildList(impl.map(f))
  
  override def toString: String =
    s"ChildList(${impl})"
}

case class MySet[A](impl: Set[A]) extends Mappable[A, MySet[A]] {
  def map(
    f: A => A
  )
  : MySet[A] =
    MySet(impl.map(f))
}


def processString(string: String): String =
  string + "!"

def processIterable[
  L[X] <: Mappable[X, L[X]]
](
  strings: L[String]
)
: L[String] =
  strings.map { string =>
    processString(string)
  }

println(processString("hello")) // hello!
println(processIterable(MyList(List("hello", "world")))) // MyList(List(hello!, world!))
println(processIterable(new ChildList(List("hello", "world")))) // ChildList(List(hello!, world!))
println(processIterable(MySet(Set("hello", "world")))) // MySet(Set(hello!, world!))


























































































