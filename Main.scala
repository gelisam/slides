  ///////////////////////////
 // add a type parameter! //
///////////////////////////


sealed trait List[A]
case class Nil[A]()                        extends List[A]
case class Cons[A](head: A, tail: List[A]) extends List[A]


import java.net.URL
import scala.xml.Document

case class Webpage[A,F[_]](
  location: URL,
  content:  A,
  title:    F[ String ],
  links:    F[ List[(String,URL)] ],
  referrer: Option[URL]
)

type Missing[A] = Unit
type Present[A] = A
def download(ref: Webpage[Unit,Missing]): Webpage[String,Missing] = ???
def parse(page: Webpage[String,Missing]): Webpage[Document,Present] = ???




























































































