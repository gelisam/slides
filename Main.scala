import scala.collection.TraversableLike
import scala.collection.generic.CanBuildFrom

def processString(string: String): String =
  string + "!"

def processMany[
  L[X] <: TraversableLike[X, L[X]]
](
  strings: L[String]
)(implicit
  cbf: CanBuildFrom[  L[String], Int, L[Int]  ]
)
: L[Int] =
  strings.map(processString)


println(processString("hello")) // 5
println(processMany(List("hello", "world")): List[Int]) // List(5, 5)
println(processMany(Set("hello", "world")): Set[Int]) // Set(5)

























































































