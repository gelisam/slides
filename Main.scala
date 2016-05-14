import String
import Set exposing (Set)

-- >>> processString "hello"
-- 5
processString : String -> Int
processString = String.length

-- >>> processList ["hello", "world"]
-- [5, 5]
processList : List String -> List Int
processList = List.map processString

-- >>> processSet (Set.fromList ["hello", "world"])
-- Set.fromList [5]
processSet : Set String -> Set Int
processSet = Set.map processString


-- >>> processListHelper ["hello", "world"]
-- [5, 5]
processListHelper : List String -> List Int
processListHelper = processList

-- >>> processSetHelper (Set.fromList ["hello", "world"])
-- Set.fromList [5]
processSetHelper : Set String -> Set Int
processSetHelper = processSet



























































































