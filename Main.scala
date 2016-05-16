import scala.collection.TraversableLike
import scala.collection.generic.CanBuildFrom

// >>> processString("hello")
// 5
def processString(string: String): Int =
  string.length

// >>> processList(List("hello", "world"))
// List(5, 5)
def processList(strings: List[String]): List[Int] =
  strings.map(processString)

// >>> processSet(Set("hello", "world"))
// Set(5)
def processSet(strings: Set[String]): Set[Int] =
  strings.map(processString)

// >>> processMany(List("hello", "world"))
// List(5, 5)
// >>> processMany(Set("hello", "world"))
// Set(5)
def processMany[L[_] : Mappable](
  strings: L[String]
)
: L[Int] =
  strings.fmap(processString)



























































































