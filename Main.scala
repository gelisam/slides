


def processString(string: String): Int =
  string.length

def processIterable[
  L[X] <: Iterable[X]
](
  strings: L[String]
)
: L[Int] =
  // trait Iterable {
  //   def map(
  //     f: String => Int
  //   )
  //   : Iterable[Int]
  // }
  strings.map { string =>
    processString(string)
  }

println(processString("hello")) // hello!
println(processIterable(List("hello", "world")): List[Int])
println(processIterable(Set("hello", "world")): Set[Int])


























































































