  ///////////////////////////
 // add a type parameter! //
///////////////////////////


sealed trait List[A]
case class Nil[A]()                        extends List[A]
case class Cons[A](head: A, tail: List[A]) extends List[A]


import java.net.URL
import scala.xml.Document

case class Webpage[C,T,L](
  location: URL,
  content:  C,
  title:    T,
  links:    L,
  referrer: Option[URL]
)

def download(
  ref: Webpage[Unit, Unit, Unit]
): Webpage[
     Document,
     String,
     List[(String,URL)]
   ]= ???






























































































