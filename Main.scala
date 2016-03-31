  ///////////////////////////
 // add a type parameter! //
///////////////////////////


sealed trait List[A]
case class Nil[A]()                        extends List[A]
case class Cons[A](head: A, tail: List[A]) extends List[A]


import java.net.URL

case class Webpage(
  location: URL,
  content:  Option[String],
  referrer: Option[URL]
)

def download(ref: Webpage): Webpage = ???

def render(page: Webpage) {
  val content = page.content.get
  // ...
}






























































































