class Sun extends Animation {
  private PShape sun;
  private PShape moon;
  private int riseHeight;

  private float sunStartY;
  private float rx;
  private float ry;
  private int sunRadian;
  private int moonRadian;

  private InterpolatingColor c;

  public Sun(int duration, int sunRadian, int moonRadian, PVector startPos, int riseHeight, InterpolatingColor c) {
    super(duration);

    this.riseHeight = riseHeight;

    this.c = c;

    this.sunRadian = sunRadian;
    this.moonRadian = moonRadian;
    this.sunStartY = startPos.y;
    this.rx = startPos.x;
    this.ry = startPos.y;
    this.sun = loadShape("sun.svg");
    this.sun.setStrokeWeight(0);
    this.moon = createShape(ELLIPSE, 0, 0, moonRadian, moonRadian);
    this.moon.setStrokeWeight(0);
  }

  public void update(int durationProgress) {
    float durationProgressPercent = this.getAnimationProgressPercentage(durationProgress);
    float sine = (float)Math.sin(PI * durationProgressPercent);
    this.rx = (float)width * durationProgressPercent;
    this.ry = this.sunStartY - (float)sine * (float)this.riseHeight;

    color col = this.c.getColor(durationProgress);
    float alphaSun = 255 * sine;
    float alphaMoon = 255 * (1 - sine);
    color colSun = color(red(col), green(col), blue(col), alphaSun);
    color colMoon = color(red(col), green(col), blue(col), alphaMoon);

    this.sun.setFill(colSun);
    this.moon.setFill(colMoon);
  }

  private void draw() {
    // WHY IS THIS NEEDED?
    shapeMode(CENTER);
    shape(this.sun, this.rx, this.ry, this.sunRadian, this.sunRadian);
    shapeMode(CORNER);

    shape(this.moon, this.rx, this.ry, this.moonRadian, this.moonRadian);
  }
}
