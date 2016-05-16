import scala.collection.TraversableLike
import scala.collection.generic.CanBuildFrom

def processString(string: String): Int =
  string.length

def processMany[
  L[X] <: Iterable[X]
](
  strings: L[String]
)


: L[Int] =
  strings.map(processString)



























































































