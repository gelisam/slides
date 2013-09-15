// data Frame = Strike
//            | Spare
//            | Miss

public abstract class Frame {
  private Frame() {}
  
  public static class Strike extends Frame {
    public Strike() {}
  }
  
  public static class Spare extends Frame {
    public Spare() {}
  }
  
  public static class Miss extends Frame {
    public Miss() {}
  }
}
