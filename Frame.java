// data Frame = Strike
//            | Spare Int
//            | Miss  Int Int

public abstract class Frame {
  private Frame() {}
  
  public static class Strike extends Frame {
    public Strike() {}
  }
  
  public static class Spare extends Frame {
    public Spare(int first_roll) {}
  }
  
  public static class Miss extends Frame {
    public Miss(int first_roll, int second_roll) {}
  }
}
