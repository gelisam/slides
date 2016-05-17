>>> List(1,2,3).monoMap { x => x + 1 }
List(2, 3, 4)

>>> Set(1,2,3).monoMap { x => x + 1 }
Set(2, 3, 4)

>>> import scala.collection.immutable.BitSet
>>> BitSet(1,2,3).monoMap { x => x + 1 }
BitSet(2, 3, 4)


def processMany[
  L[X] <: MonoMappable[X, L[X]]
](
  strings: L[String]
)
: L[Int] =
  strings.monoMap(processString)


























































































