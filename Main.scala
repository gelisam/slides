import scala.collection.TraversableLike
import scala.collection.generic.CanBuildFrom

def processString(string: String): String =
  string + "!"

def processIterable[
  L[_] <: Iterable[_]
](
  strings: L[String]
)(implicit
  bf: CanBuildFrom[L[String], Int, L[Int]]
)
: L[Int] =
  // trait Iterable {
  //   def map[L_Int](
  //     f: String => Int
  //   )(implicit
  //     bf: CanBuildFrom[Iterable[String], Int, L_Int]
  //   )
  //   : L_Int
  // }
  strings.map[Int,L[Int]]( string =>
    processString(string)
  )(bf)

println(processString("hello")) // hello!
println(processIterable(List("hello", "world")): List[Int])
println(processIterable(Set("hello", "world")): Set[Int])


























































































