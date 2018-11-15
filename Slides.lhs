monoidal-containers
===

> import Data.Map

> foo = [(1, ["one"]), (2, ["two"])]
> bar =               [(2, ["TWO"]), (3, ["THREE"])]

>>> Map.fromList foo <> Map.fromList bar
fromList [(1, ["one"]), (2, ["two"]), (3, ["THREE"])]
