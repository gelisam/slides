// Here is one you do want to use:

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











