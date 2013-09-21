// data Frame = Strike
//            | Spare Int
//            | Miss  Int Int

// using algebraic types in Haskell:
// 
// rolls :: Frame -> [Pins]
// rolls Strike     = [10]
// rolls (Spare n)  = [n, 10-n]
// rolls (Miss n m) = [n, m]

// object-oriented version:
public abstract class Frame {
  private Frame() {}
  
  public abstract int[] rolls();
  
  
  public static class Strike extends Frame {
    public Strike() {}
    
    public int[] rolls() {
      return new int[] {10};
    }
  }
  
  public static class Spare extends Frame {
    private final int r1;
    public Spare(int first_roll) {
      r1 = first_roll;
    }
    
    public int[] rolls() {
      return new int[] {r1, 10 - r1};
    }
  }
  public static class Miss extends Frame {
    private final int r1;
    private final int r2;
    public Miss(int first_roll, int second_roll) {
      r1 = first_roll;
      r2 = second_roll;
    }
    
    public int[] rolls() {
      return new int[] {r1, r2};
    }
  }
}
