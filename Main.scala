import scala.collection.TraversableLike
import scala.collection.generic.CanBuildFrom

def processString(string: String): Int =
  string.length

def processMany[
  L[X] <: TraversableLike[X, L[X]]
](
  strings: L[String]
)(implicit
  cbf: CanBuildFrom[  L[String], Int, L[Int]  ]
)
: L[Int] =
  strings.map(processString)



























































































