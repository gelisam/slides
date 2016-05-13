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

def processHelper[
  L[X] <: TraversableLike[X, L[X]]
](
  strings: L[String]
)(implicit
  cbf1: CanBuildFrom[  L[String],      Future[Int], L[Future[Int]]  ],
  cbf2: CanBuildFrom[  L[Future[Int]], Int,         L[Int]          ]
)
: Future[L[Int]] =
  processMany(strings)


val r1: Future[Int]       = processString("hello")
val r2: Future[List[Int]] = processHelper(List("hello", "world"))
val r3: Future[Set[Int]]  = processHelper(Set("hello", "world"))

r1.map(println) // 5
r2.map(println) // List(5, 5)
r3.map(println) // Set(5)


























































































