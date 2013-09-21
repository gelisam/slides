// data Maybe a = Nothing
//              | Just a

abstract class Maybe<A> {
  private Maybe() {}
  
  
  public static class Nothing extends Maybe {
    public Nothing() {}
  }
  
  public static class Just<A> extends Maybe<A> {
    public Just(A a) {value = a;}
    public A value;
  }
}

class Example {
  void process(String value) {
    if (value != null) {  // easy to forget
      
      
      
      // process value
    }
  }
}
