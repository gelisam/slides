









// a compromise:

class Nullable<A> {
  private Nullable(A a) {value = a;}
  public A value;
}

class Example {
  void process(Nullable<String> nullable_value) {
    if (nullable_value.value != null) {
      String value = nullable_value.value;
      
      
      // process value
    }
  }
}
