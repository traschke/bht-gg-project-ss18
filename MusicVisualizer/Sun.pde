/***
*
*/
class Sun {
  private int duration;

  private PShape sun;
  private int sunRiseHeight;

  private float sunStartY;
  private float rx;
  private float ry;
  private int sunRadian;

  private InterpolatingColor c;

  public Sun(int duration, int sunRadian, PVector sunStartPos, int sunRiseHeight, InterpolatingColor c) {
    this.duration = duration;

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
    float durationProgressPercent = this.getDurationProgressPercentage(durationProgress);
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

  // private void drawTimebar(int durationProgress) {
  //   float durationProgressPercent = this.getDurationProgressPercentage(durationProgress);
  //   float timebarProgressWidth = (float)width * durationProgressPercent;

  //   PShape timebar = createShape(RECT, 0, 0, timebarProgressWidth, height/50);
  //   timebar.setStrokeWeight(0);

  //   shape(timebar);
  // }

  private float getDurationProgressPercentage(int durationProgress) {
    return (float)durationProgress / (float)this.duration;
  }
}
