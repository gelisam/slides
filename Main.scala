
def processString(string: String): String =
  string + "!"

def processList(strings: List[String]): List[Int] =
  strings.map(processString)

def processSet(strings: Set[String]): Set[Int] =
  strings.map(processString)


println(processString("hello")) // 5
println(processList(List("hello", "world"))) // List(5, 5)
println(processSet(Set("hello", "world"))) // Set(5)

























































































