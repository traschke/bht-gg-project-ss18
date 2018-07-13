/***
* Represents a character that can jump.
*/
class Player {
  private PShape playerSprite;

  private int jumpHeight;

  private int jumpMillisDuration;
  private int jumpMillisBegin;
  private int jumpMillisEnd;

  public Player(int xPos, int yPos, int width, int height, int jumpHeight, int jumpMillisDuration) {
    this.playerSprite = createShape(RECT, xPos, yPos - height, width, height);
    this.playerSprite.setFill(color(255, 255, 255));
    this.playerSprite.setStrokeWeight(0);

    this.jumpHeight = jumpHeight;
    this.jumpMillisDuration = jumpMillisDuration;
  }

  public void jump() {
      this.playerSprite.setFill(color(255, 0, 0));
      this.jumpMillisBegin = millis();
      this.jumpMillisEnd = this.jumpMillisBegin + this.jumpMillisDuration;
  }

  public void draw() {
    int millisSinceJumpBegin = millis() - this.jumpMillisBegin;
    float durationPercentage = (float)millisSinceJumpBegin / (float)this.jumpMillisDuration;
    
    if (durationPercentage <= 1.0) {
      double sine = Math.sin(PI * durationPercentage);
      double currentJumpHeight = sine * (double)this.jumpHeight;
      // * -1 because the zero point of the scene is in the upper left corner!
      this.playerSprite.resetMatrix();
      this.playerSprite.translate(0, Math.round(currentJumpHeight) * -1);
    } else {
      this.rest();
    }

    shape(this.playerSprite);
  }

  private void rest() {
    this.playerSprite.setFill(color(255, 255, 255));
    this.playerSprite.resetMatrix();
  }

  public PShape getPlayerSprite() {
    return this.playerSprite;
  }
}
