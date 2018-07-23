/***
* Represents a character that can jump.
*/
class Player {
  private PShape playerSprite;

  private float jumpHeight;

  private int jumpMillisDuration;
  private int jumpMillisBegin;
  private int jumpMillisEnd;

  private PVector pos;
  private PVector scale;

  public Player(float xPos, float yPos, float w, float h, float jumpHeight, int jumpMillisDuration) {
    this.playerSprite = loadShape("tyre.svg");
    this.pos = new PVector(xPos, yPos);
    this.scale = new PVector(w/this.playerSprite.width, h/this.playerSprite.height);

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
    float currentJumpHeight = 0;

    int millisSinceJumpBegin = millis() - this.jumpMillisBegin;
    float durationPercentage = (float)millisSinceJumpBegin / (float)this.jumpMillisDuration;
    if (durationPercentage <= 1.0) {
      float sine = (float)Math.sin(PI * durationPercentage);
      currentJumpHeight = sine * this.jumpHeight;
    } else {
      this.rest();
    }

    pushMatrix();
    scale(this.scale.x, this.scale.y);
    translate(this.pos.x / this.scale.x, this.pos.y / this.scale.y - this.playerSprite.height);
    translate(0, -currentJumpHeight / this.scale.y);
    shape(this.playerSprite);
    popMatrix();
  }

  private void rest() {
    this.playerSprite.setFill(color(255, 255, 255));
  }

  public PShape getPlayerSprite() {
    return this.playerSprite;
  }
}
