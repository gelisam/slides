


def processString(string: String): Int =
  string.length

def processList(strings: List[String]): List[Int] =
  strings.map { string =>
    processString(string)
  }

def processSet(strings: Set[String]): Set[Int] =
  strings.map { string =>
    processString(string)
  }

println(processString("hello")) // 5
println(processList(List("hello", "world"))) // List(5, 5)
println(processSet(Set("hello", "world"))) // Set(5)


























































































