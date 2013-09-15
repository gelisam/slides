import junit.framework.TestCase;

public class Bowling extends TestCase {
  private ScoreCard scoreCard;

  public Bowling(String testName) {
    super(testName);
  }

  protected void setUp() throws Exception {
    super.setUp();
    scoreCard = new ScoreCard();
  }

  protected void tearDown() throws Exception {
    super.tearDown();
    scoreCard = null;
  }

  public void testPerfectGame() {
    for(int i=0; i<12; ++i) {
      scoreCard.knockDown(10);
    }
    scoreCard.computeScore();
    assertEquals(scoreCard.getScore(), 300);
  }

  public void testAllNines() {
    for(int i=0; i<10; ++i) {
      scoreCard.knockDown(9);
      scoreCard.knockDown(0);
    }
    scoreCard.computeScore();
    assertEquals(scoreCard.getScore(), 90);
  }

  public void testAllSpares() {
    for(int i=0; i<10; ++i) {
      scoreCard.knockDown(5);
      scoreCard.knockDown(5);
    }
    scoreCard.knockDown(5);
    scoreCard.computeScore();
    assertEquals(scoreCard.getScore(), 150);
  }
}
