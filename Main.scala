import scala.collection.TraversableLike
import scala.collection.generic.CanBuildFrom
import scala.concurrent.Future
import scala.concurrent.ExecutionContext.Implicits.global


def processString(string: String): Future[Int] =
  Future.successful(string.length)

def processMany[
  L[X] <: TraversableLike[X, L[X]]
](
  strings: L[String]
)(implicit
  cbf1: CanBuildFrom[  L[String],      Future[Int], L[Future[Int]]  ],
  cbf2: CanBuildFrom[  L[Future[Int]], Int,         L[Int]          ]
)
: Future[L[Int]] =
  Future.sequence(
    strings.map(processString)
  )


val r1: Future[Int]       = processString("hello")
val r2: Future[List[Int]] = processMany(List("hello", "world"))
val r3: Future[Set[Int]]  = processMany(Set("hello", "world"))

r1.map(println) // 5
r2.map(println) // List(5, 5)
r3.map(println) // Set(5)


























































































