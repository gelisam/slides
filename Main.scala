


def processString(string: String): String =
  string + "!"

def processIterable[
  L[_] <: Iterable[_]
](
  strings: L[String]
)
: L[Int] =
  // trait Iterable {
  //   def map[L_Int](
  //     f: String => Int
  //   )
  //   : L_Int
  // }
  strings.map { string =>
    processString(string)
  }

println(processString("hello")) // hello!
println(processIterable(List("hello", "world")): List[Int])
println(processIterable(Set("hello", "world")): Set[Int])


























































































