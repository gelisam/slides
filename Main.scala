trait Eq1[S[_], T[_]] {
  def at[A]: S[A] =:= T[A]
}

object Eq1 {
  implicit def refl1[T[_]]: Eq1[T,T] = new Eq1[T,T] {
    def at[A]: T[A] =:= T[A] = implicitly
  }
}


trait Mappable[A] {
  type Self[X]
  
  def map[L[X],B](
    f: A => B
  )(implicit
    eq1: Eq1[Self,L]
  )
  : L[B]
}

case class MyList[A](impl: List[A]) extends Mappable[A] {
  type Self[X] = MyList[X]
  
  def map[L[X],B](
    f: A => B
  )(implicit
    eq1: Eq1[Self,L]
  )
  : L[B] = {
    implicit val eqB = eq1.at[B]
    MyList(impl.map(f))
  }
}

case class MySet[A](impl: Set[A]) extends Mappable[A] {
  type Self[X] = MySet[X]
  
  def map[L[X],B](
    f: A => B
  )(implicit
    eq1: Eq1[Self,L]
  )
  : L[B] = {
    implicit val eqB = eq1.at[B]
    MySet(impl.map(f))
  }
}


def processString(string: String): String =
  string + "!"

def processIterable[
  L[X] <: Mappable[X]
](
  strings: L[String]
)(implicit
  eq1: Eq1[strings.Self,L]
)
: L[Int] =
  strings.map { string =>
    processString(string)
  }(eq1).map { x =>
    x + 1
  }(eq1)

println(processString("hello")) // hello!
println(processIterable(MyList(List("hello", "world"))))
println(processIterable(MySet(Set("hello", "world"))))


























































































