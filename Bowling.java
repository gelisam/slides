import junit.framework.TestCase;

public class Bowling extends TestCase {
  public Bowling(String testName) {
    super(testName);
  }

  public void testPerfectGame() {
    assertEquals(ScoreCard.score("XXXXXXXXXXXX"), 300);
  }

  public void testAllNines() {
    assertEquals(ScoreCard.score("9-9-9-9-9-9-9-9-9-9-"), 300);
  }

  public void testAllSpares() {
    assertEquals(ScoreCard.score("5/5/5/5/5/5/5/5/5/5/5"), 150);
  }
}
