/***
* Represents a character that can jump.
*/
class Player extends ScalableShape {
  private float jumpHeight;

  private int jumpMillisDuration;
  private int jumpMillisBegin;
  private int jumpMillisEnd;

  private color c;

  private float rotationSpeed;

  public Player(float xPos, float yPos, float height, float jumpHeight, int jumpMillisDuration, float rotationSpeed) {
    super(loadShape("tyre.svg"), xPos, yPos, height, ScalableShape.TYPE_HEIGHT);
    this.c = color(54, 69, 79);
    this.shape.setFill(this.c);
    this.shape.setStrokeWeight(0);

    this.jumpHeight = jumpHeight;
    this.jumpMillisDuration = jumpMillisDuration;

    this.rotationSpeed = rotationSpeed;
  }

  public void jump() {
      // this.shape.setFill(color(255, 0, 0));
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

    float angle = millis() * this.rotationSpeed;

    PVector scaledPos = this.getScaledPos();
    PVector scaledCurrentJumpHeight = this.scaleVector(new PVector(0, -currentJumpHeight));
    pushMatrix();
    // translate(this.shape.width/2, this.shape.height/2);
    // translate(-this.shape.width/2, -this.shape.height/2);
    // translate(-width/2, -height/2);
    scale(this.scale.x, this.scale.y);
    translate(scaledPos.x, scaledPos.y);
    translate(scaledCurrentJumpHeight.x, scaledCurrentJumpHeight.y);

    // Translate to center of shape, rotate, translate back
    translate(this.shape.width/2, this.shape.height/2);
    rotate(angle);
    translate(-this.shape.width/2, -this.shape.height/2);

    shape(this.shape);
    popMatrix();
  }

  private void rest() {
    this.shape.setFill(this.c);
  }
}
