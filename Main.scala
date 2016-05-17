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


trait Mappable[L[_]] {
  def fmap[A,B](xs: L[A], f: A => B): L[B]
}

implicit val mappableList: Mappable[List] = new Mappable[List] {
  def fmap[A,B](xs: List[A], f: A => B): List[B] =
    xs.map(f)
}

implicit val mappableSet: Mappable[Set] = new Mappable[Set] {
  def fmap[A,B](xs: Set[A], f: A => B): Set[B] =
    xs.map(f)
}


trait RichMappable[L[_], A] {
  def fmap[B](f: A => B): L[B]
}

implicit def richMappable[L[_], A](
  xs: L[A]
)(implicit
  mappable: Mappable[L]
)
: RichMappable[L,A] = new RichMappable[L,A] {
  def fmap[B](f: A => B): L[B] =
    mappable.fmap(xs, f)
}


// >>> processMany(List("hello", "world"))
// List(5, 5)
// >>> processMany(Set("hello", "world"))
// Set(5)
def processMany[L[_]: Mappable](
  strings: L[String]
)
: L[Int] =
  strings.fmap(processString)
























































































main :: IO ()
main = putStrLn "typechecks."
