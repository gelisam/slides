  ///////////////////////////
 // add a type parameter! //
///////////////////////////


sealed trait List[A]
case class Nil[A]()                        extends List[A]
case class Cons[A](head: A, tail: List[A]) extends List[A]


import java.net.URL
import scala.xml.Document

case class Webpage(
  location: URL,
  content:  Document,
  title:    String,
  links:    List[(String,URL)],
  referrer: Option[URL]
)































































































