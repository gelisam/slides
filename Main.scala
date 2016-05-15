
trait Mappable[A] {
  type Self
  
  def map[L[X]](
    f: A => A
  )(implicit
    eq: Self =:= L[A]
  )
  : L[A]
}

case class MyList[A](impl: List[A]) extends Mappable[A] {
  type Self = MyList[A]
  
  def map[L[X]](
    f: A => A
  )(implicit
    eq: Self =:= L[A]
  )
  : L[A] =
    MyList(impl.map(f))
}

case class MySet[A](impl: Set[A]) extends Mappable[A] {
  type Self = MySet[A]
  
  def map[L[X]](
    f: A => A
  )(implicit
    eq: Self =:= L[A]
  )
  : L[A] =
    MySet(impl.map(f))
}


def processString(string: String): String =
  string + "!"

def processIterable[
  L[X] <: Mappable[X]
](
  strings: L[String]
)(implicit
  eq: strings.Self =:= L[String]
)
: L[String] =
  strings.map { string =>
    processString(string)
  }.map { x =>
    x + 1
  }

println(processString("hello")) // hello!
println(processIterable(MyList(List("hello", "world"))))
println(processIterable(MySet(Set("hello", "world"))))


























































































