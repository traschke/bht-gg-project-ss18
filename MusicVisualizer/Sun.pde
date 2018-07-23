class Sun extends ScalableShape {
  private Animation animation;

  private float riseHeight;
  private float currentRiseHeight;
  private InterpolatingColor c;

  public Sun(float x, float y, float size, int sizeType, float riseHeight, int animationLength, InterpolatingColor c) {
    super(loadShape("sun.svg"), x, y, size, sizeType);
    this.animation = new Animation(animationLength);
    this.riseHeight = riseHeight;
    this.c = c;
  }

  public Sun(PShape shape, float x, float y, float size, int sizeType, float riseHeight, int animationLength, InterpolatingColor c) {
    super(shape, x, y, size, sizeType);
    this.animation = new Animation(animationLength);
    this.riseHeight = riseHeight;
    this.c = c;
  }

  public void update(int animationProgress) {
    float durationProgressPercent = this.animation.getAnimationProgressPercentage(animationProgress);
    float sine = (float)Math.sin(PI * durationProgressPercent);
    float newX = (float)width * durationProgressPercent;
    this.currentRiseHeight = sine * this.riseHeight;
    this.pos.set(newX, this.pos.y);

    this.shape.setFill(this.c.getColor(animationProgress));
  }

  public void draw() {
    PVector scaledPos = this.getScaledPos();
    PVector scaledCurrentRiseHeight = this.scaleVector(new PVector(0, -this.currentRiseHeight));
    shapeMode(CENTER);
    pushMatrix();
    scale(this.scale.x, this.scale.y);
    translate(scaledPos.x, scaledPos.y);
    translate(scaledCurrentRiseHeight.x, scaledCurrentRiseHeight.y);
    shape(this.shape);
    popMatrix();
    shapeMode(CORNER);
  }
}
