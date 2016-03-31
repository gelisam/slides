  ///////////////////////////
 // add a type parameter! //
///////////////////////////


sealed trait List[A]
case class Nil[A]()                        extends List[A]
case class Cons[A](head: A, tail: List[A]) extends List[A]


import java.net.URL

case class Webpage[A](
  location: URL,
  content:  A,
  referrer: Option[URL]
)

def download(ref: Webpage[Unit]): Webpage[String] = ???

import scala.xml.Document
def parse(page: Webpage[String]): Webpage[Document] = ???

def render(page: Webpage[Document]) {
  val content = page.content
  // ...
}






























































































