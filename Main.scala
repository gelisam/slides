>>> List(1,2,3).map { x => s"${x}!" }
List(1!, 2!, 3!)

>>> Set(1,2,3).map { x => s"${x}!" }
Set(1!, 2!, 3!)

>>> import scala.collection.immutable.BitSet
>>> BitSet(1,2,3).map { x => s"${x}!" }
SortedSet(1!, 2!, 3!)

>>> import scala.collection.generic.CanBuildFrom
>>> implicitly[CanBuildFrom[ List[Int], String, List[String] ]]
OK
>>> implicitly[CanBuildFrom[ Set[Int], String, Set[String] ]]
OK

>>> implicitly[CanBuildFrom[ BitSet, Int, BitSet ]]
OK
>>> implicitly[CanBuildFrom[ BitSet, String, BitSet ]]
NOT FOUND

























































































