class Sun extends Animation {
  private PShape sun;
  private int sunRiseHeight;

  private float sunStartY;
  private float rx;
  private float ry;
  private int sunRadian;

  private InterpolatingColor c;

  public Sun(int duration, int sunRadian, PVector sunStartPos, int sunRiseHeight, InterpolatingColor c) {
    super(duration);

    this.sunRiseHeight = sunRiseHeight;

    this.c = c;

    this.sunRadian = sunRadian;
    this.sunStartY = sunStartPos.y;
    this.rx = sunStartPos.x;
    this.ry = sunStartPos.y;
    // this.sun = createShape(ELLIPSE, sunStartPos.x, sunStartPos.y, sunRadian, sunRadian);
    this.sun = loadShape("sun.svg");
    // this.sun.setFill(color(255, 255, 0));
    this.sun.setStrokeWeight(0);
  }

  public void update(int durationProgress) {
    float durationProgressPercent = this.getAnimationProgressPercentage(durationProgress);
    double sine = Math.sin(PI * durationProgressPercent);
    this.rx = (float)width * durationProgressPercent;
    this.ry = this.sunStartY - (float)sine * (float)this.sunRiseHeight;

    this.sun.setFill(this.c.getColor(durationProgress));
  }

  private void draw() {
    shapeMode(CENTER);
    shape(this.sun, this.rx, this.ry, this.sunRadian, this.sunRadian);
    shapeMode(CORNER);
  }
}
