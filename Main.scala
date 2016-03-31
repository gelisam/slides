  /////////////////////////////////////////
 // composing network operating systems //
/////////////////////////////////////////

import java.net.URL
class OS {
  def getCurrentTimeMillis: Long = ???

  def srand(seed: Int): Unit = ???
  def rand: Int = ???

  case class FileDescriptor(n: Int)
  def read(fd: FileDescriptor, byte_count: Int): List[Byte] = ???
  def write(fd: FileDescriptor, bytes: List[Byte]): Int = ???

  def accept(url: URL, port: Int): FileDescriptor = ???
  def connect(url: URL, port: Int): FileDescriptor = ???
  
  def system(command: String): String = ???
}

class SlowOS extends OS {
  override def getCurrentTimeMillis: Long =
    (super.getCurrentTimeMillis * 0.5).toLong
}





























































































