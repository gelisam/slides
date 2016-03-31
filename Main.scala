  ///////////////////////////
 // add a type parameter! //
///////////////////////////


sealed trait List[A]
case class Nil[A]()                        extends List[A]
case class Cons[A](head: A, tail: List[A]) extends List[A]


import java.net.URL

case class Webpage(
  location: URL,
  content:  String,
  referrer: Option[URL]
)

def download(location: URL, referrer: Option[URL]): Webpage = ???































































































