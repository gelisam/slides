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

class TimeTravellingOS extends OS {
  override def getCurrentTimeMillis: Long =
    Long.MaxValue - super.getCurrentTimeMillis
}

class DeterministicOS extends OS {
  override def srand(seed: Int): Unit =
    super.srand(1234)
}

class DiskFullOS extends OS {
  override def write(fd: FileDescriptor, bytes: List[Byte]): Int =
    throw new java.io.IOException("Not enough space")
}

class DenialOfServiceOS extends OS {
  val fullFileDescriptor = FileDescriptor(666)
  
  override def accept(url: URL, port: Int): FileDescriptor =
    fullFileDescriptor
  
  override def read(fd: FileDescriptor, byte_count: Int): List[Byte] =
    if (fd == fullFileDescriptor)
      List(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
    else
      super.read(fd, byte_count)
}



























































































