// 
// *---*     *---*     *---*     *---*     *---*
// |///| <-> | A | <-> | B | <-> | C | <-> |///|
// *---*     *---*     *---*     *---*     *---*
// 
public class Carousel extends PagerAdapter {
  private PagerAdapter pages;
  
  public Carousel(PagerAdapter adapter) {
    pages = adapter;
  }
  
  
  public int getCount() {
    return pages.getCount() + 2;
  }
  
  public View getItem(int position) {
    int i;
    if (position == 0) {
      i = pages.getCount() - 1;
      setPosition(getCount() - 1);
    } else if (position == pages.getCount() + 1) {
      i = 0;
      setPosition(0);
    } else {
      i = position - 1;
    }
    return pages.getItem(i);
  }
}
























