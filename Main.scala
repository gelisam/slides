>>> List(1,2,3).fmap { x => s"${x}!" }
List(1!, 2!, 3!)

>>> Set(1,2,3).fmap { x => s"${x}!" }
Set(1!, 2!, 3!)

>>> import scala.collection.immutable.BitSet
>>> BitSet(1,2,3).fmap { x => s"${x}!" }
TYPE ERROR


def processMany[
  L[X] <: Mappable[X, L[X]]
](
  strings: L[String]
)
: L[Int] =
  strings.fmap(processString)


























































































