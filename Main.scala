trait Functor[L[_]] {
  def map[A,B](xs: L[A])(f: A => B): L[B]
}


def processString(string: String): Int =
  string.length

def processMany[L[_]](
  strings: L[String]
)(implicit
  functor: Functor[L]
)
: L[Int] =
  functor.map(strings)(processString)


println(processString("hello")) // hello!
println(processList(List("hello", "world"))) // List(hello!, world!)
println(processSet(Set("hello", "world"))) // Set(hello!, world!)

























































































