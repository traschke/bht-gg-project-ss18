/***
* Represents a character that can jump.
*/
class Player {
  private PShape playerSprite;

  private int jumpHeight;
  private float currentHeight = 0;

  private int jumpMillisDuration;
  private int jumpMillisBegin;
  private int jumpMillisEnd;
  private int jumpMillisPeak;

  private float jumpStepSize;

  private int lastMillisSinceJumpBegin;

  private boolean isGoingUp = false;
  private boolean isGoingDown = false;

  public Player(int xPos, int yPos, int width, int height, int jumpHeight, int jumpMillisDuration) {
    this.playerSprite = createShape(RECT, xPos, yPos - height, width, height);
    this.playerSprite.setFill(color(255, 255, 255));
    this.playerSprite.setStrokeWeight(0);

    this.jumpHeight = jumpHeight;
    this.jumpMillisDuration = jumpMillisDuration;
    // Needs to be two times as high, because we want the max height at jump height peak
    this.jumpStepSize = 2.0 * ((float)this.jumpHeight / (float)this.jumpMillisDuration);
  }

  public void jump() {
    if (!this.isJumping()) {
      this.playerSprite.setFill(color(255, 0, 0));
      this.isGoingUp = true;
      this.isGoingDown = false;
      this.jumpMillisBegin = millis();
      this.jumpMillisEnd = this.jumpMillisBegin + this.jumpMillisDuration;
      this.jumpMillisPeak = this.jumpMillisBegin + (this.jumpMillisDuration / 2);
    } else {
      println("Cannot jump!");
    }
  }

  public void draw() {
    int millisSinceJumpBegin = millis() - this.jumpMillisBegin;

    if (this.isGoingUp && millis() >= this.jumpMillisPeak) {
      this.changeDirection();
    } else if (this.isGoingDown && millis() >= this.jumpMillisEnd) {
      this.rest();
    }

    if (millisSinceJumpBegin < this.jumpMillisDuration) {
      int millisSinceJumpBeginDelta = millisSinceJumpBegin - this.lastMillisSinceJumpBegin;
      float currentJumpStepSize = (float)millisSinceJumpBeginDelta * this.jumpStepSize;
      this.lastMillisSinceJumpBegin = millisSinceJumpBegin;      

      if (this.isGoingUp) {
        this.currentHeight += currentJumpStepSize;
      } else if (this.isGoingDown) {
        this.currentHeight -= currentJumpStepSize;
      }
    }

    // * -1 because the zero point of the scene is in the upper left corner!
    translate(0, this.currentHeight * -1);
    shape(this.playerSprite);
  }

  private void changeDirection() {
    // println("Changing direction");
    this.playerSprite.setFill(color(0, 255, 0));
    this.isGoingUp = false;
    this.isGoingDown = true;
  }

  private void rest() {
    // println("Going to rest");
    this.playerSprite.setFill(color(255, 255, 255));
    this.isGoingUp = false;
    this.isGoingDown = false;
    this.currentHeight = 0.0;
    this.lastMillisSinceJumpBegin = 0;
  }

  private boolean isJumping() {
    return this.isGoingUp || this.isGoingDown;
  }

  public PShape getPlayerSprite() {
    return this.playerSprite;
  }
}
