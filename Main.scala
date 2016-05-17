>>> List(1,2,3).mapTo[List] { x => s"${x}!" }
List(1!, 2!, 3!)

>>> Set(1,2,3).mapTo[Set] { x => s"${x}!" }
Set(1!, 2!, 3!)

>>> import scala.collection.immutable.BitSet
>>> BitSet(1,2,3).mapTo[SortedSet] { x => s"${x}!" }
SortedSet(1, 2, 3)


def processMany[
  L[X] <: MapConvertible[X, L[X]]
](
  strings: L[String]
)(implicit
  cbf: Convertible[  L[String], Int, L[Int]  ]
)
: L[Int] =
  strings.mapTo[L](processString)


























































































