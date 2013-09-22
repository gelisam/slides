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
  void process(Maybe<String> nullable_value) {
    if (nullable_value instanceof Maybe.Just) {
      Maybe.Just<String> just = (Maybe.Just<String>) nullable_value;
      String value = just.value;
      
      // process value
    }
  }
}
