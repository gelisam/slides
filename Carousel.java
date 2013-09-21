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
    
    
    int page = getPage(position);
    int idealPosition = canonicalPosition(page);
    
    if (position != idealPosition) {
      setPosition(idealPosition);
    }
    
    
    return pages.getItem(page);
  }
  
  
  private int canonicalPosition(int page) {
    return page + 1;
  }
  
  private int pageAt(int position) {
    return (position - 1) % pages.getCount();
  }
}


















