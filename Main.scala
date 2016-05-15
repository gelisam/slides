import java.util.*;


public class Main {
  static int processString(String string) {
    return string.length();
  }
  
  static LinkedList<Integer> processList(LinkedList<String> strings) {
    LinkedList<Integer> result = new LinkedList<Integer>();
    for(String string : strings) {
      result.add(processString(string));
    }
    return result;
  }
  
  
  public static void main(String[] args) {
    System.out.println(processString("hello")); // 5
    
    LinkedList<String> v1 = new LinkedList<String>();
    v1.addLast("hello");
    v1.addLast("world");
    System.out.println(processList(v1)); // [5, 5]
  }
}








































































































