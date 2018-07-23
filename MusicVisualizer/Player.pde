/***
* Represents a character that can jump.
*/
class Player extends ScalableShape {
  private float jumpHeight;

  private int jumpMillisDuration;
  private int jumpMillisBegin;
  private int jumpMillisEnd;

  public Player(float xPos, float yPos, float w, float h, float jumpHeight, int jumpMillisDuration) {
    super(loadShape("tyre.svg"), xPos, yPos, w, h);

    this.shape.setFill(color(255, 255, 255));
    this.shape.setStrokeWeight(0);

    this.jumpHeight = jumpHeight;
    this.jumpMillisDuration = jumpMillisDuration;
  }

  public void jump() {
      this.shape.setFill(color(255, 0, 0));
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

    PVector scaledPos = this.getScaledPos();
    PVector scaledCurrentJumpHeight = this.scaleVector(new PVector(0, -currentJumpHeight));
    pushMatrix();
    scale(this.scale.x, this.scale.y);
    translate(scaledPos.x, scaledPos.y);
    translate(scaledCurrentJumpHeight.x, scaledCurrentJumpHeight.y);
    shape(this.shape);
    popMatrix();
  }

  private void rest() {
    this.shape.setFill(color(255, 255, 255));
  }
}
