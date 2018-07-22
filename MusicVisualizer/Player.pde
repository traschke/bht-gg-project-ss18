/***
* Represents a character that can jump.
*/
class Player {
  private PShape playerSprite;

  private float jumpHeight;

  private int jumpMillisDuration;
  private int jumpMillisBegin;
  private int jumpMillisEnd;

  private float xPos;
  private float yPos;
  private float yGroundLevel;
  private float w;
  private float h;

  public Player(float xPos, float yPos, float w, float h, float jumpHeight, int jumpMillisDuration) {
    // this.playerSprite = createShape(ELLIPSE, xPos, yPos, width, height);
    this.playerSprite = loadShape("tyre2.svg");
    this.xPos = xPos;
    this.yPos = yPos-h;
    this.yGroundLevel = this.yPos;
    this.w = w;
    this.h = h;

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

  public void update() {
    int millisSinceJumpBegin = millis() - this.jumpMillisBegin;
    float durationPercentage = (float)millisSinceJumpBegin / (float)this.jumpMillisDuration;
    
    if (durationPercentage <= 1.0) {
      float sine = (float)Math.sin(PI * durationPercentage);
      float currentJumpHeight = sine * this.jumpHeight;
      
      // * -1 because the zero point of the scene is in the upper left corner!
      // this.playerSprite.resetMatrix();
      // this.playerSprite.translate(0, Math.round(currentJumpHeight) * -1);
      this.yPos = this.yGroundLevel - currentJumpHeight;
    } else {
      this.rest();
    }
    // pushMatrix();
    // this.playerSprite.resetMatrix();
    // this.playerSprite.translate(-this.w/2, -this.h/2);
    // this.playerSprite.rotate(PI/64);
    // popMatrix();
  }

  public void draw() {
    // shapeMode(CENTER);
    shape(this.playerSprite, this.xPos, this.yPos, this.w, this.h);
  }

  private void rest() {
    this.playerSprite.setFill(color(255, 255, 255));
    // this.playerSprite.resetMatrix();
    this.yPos = this.yGroundLevel;
  }

  public PShape getPlayerSprite() {
    return this.playerSprite;
  }
}
