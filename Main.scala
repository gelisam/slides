import scala.collection.TraversableLike
import scala.collection.generic.CanBuildFrom

def processString(string: String): Int =
  string.length

def processMany[
  L[_]
](
  strings: L[String]
)


: L[Int] =
  strings.map(processString) // map is not a method of L[String]



























































































