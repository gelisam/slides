
trait MyIterable[A] {
  def map[B](
    f: A => B
  )
  : MyIterable[Int]
}


def processString(string: String): Int =
  string.length

def processIterable[
  L[X] <: MyIterable[X]
](
  strings: L[String]
)
: MyIterable[Int] =
  strings.map { string =>
    processString(string)
  }

println(processString("hello")) // hello!
//println(processIterable(List("hello", "world")): List[Int])
//println(processIterable(Set("hello", "world")): Set[Int])


























































































