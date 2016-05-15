import java.util.*;
import java.util.function.*;


interface Mappable<A> {
  <B> Mappable<B> map(Function<A,B> f);
}

class MyList<A> implements Mappable<A> {
  LinkedList<A> impl;
  
  public MyList(LinkedList<A> impl) {
    this.impl = impl;
  }
  
  public <B> MyList<B> map(Function<A,B> f) {
    LinkedList<B> result = new LinkedList<B>();
    for(A element : impl) {
      result.add(f.apply(element));
    }
    return new MyList<B>(result);
  }
  
  public String toString() {
    return impl.toString();
  }
}

class MySet<A> implements Mappable<A> {
  HashSet<A> impl;
  
  public MySet(HashSet<A> impl) {
    this.impl = impl;
  }
  
  public <B> MySet<B> map(Function<A,B> f) {
    HashSet<B> result = new HashSet<B>();
    for(A element : impl) {
      result.add(f.apply(element));
    }
    return new MySet<B>(result);
  }
  
  public String toString() {
    return impl.toString();
  }
}


public class Main {
  static int processString(String string) {
    return string.length();
  }
  
  static Mappable<Integer> processMany(Mappable<String> strings) {
    return strings.map(
      (String s) -> processString(s)
    );
  }
  
  
  public static void main(String[] args) {
    System.out.println(processString("hello")); // 5
    
    LinkedList<String> v1 = new LinkedList<String>();
    v1.add("hello");
    v1.add("world");
    System.out.println(processMany(new MyList<String>(v1))); // [5, 5]
    
    HashSet<String> v2 = new HashSet<String>();
    v2.add("hello");
    v2.add("world");
    System.out.println(processMany(new MySet<String>(v2))); // [5]
  }
}








































































































