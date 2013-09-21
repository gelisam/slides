//        page 0         1         2
// *---*     *---*     *---*     *---*     *---*
// |///| <-> | A | <-> | B | <-> | C | <-> |///|
// *---*     *---*     *---*     *---*     *---*
// pos 0         1         2         3         4
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
  
  
  private int canonicalPosition(int page) {
    return page + 1;
  }
  
  private int pageAt(int position) {
    return (position - 1) % pages.getCount();
  }
}















