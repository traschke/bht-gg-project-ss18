/***
*
*/
class Sun {
  private int duration;

  private PShape sun;
  private int sunRiseHeight;

  private InterpolatingColor c;

  public Sun(int duration, int sunRadian, PVector sunStartPos, int sunRiseHeight, InterpolatingColor c) {
    this.duration = duration;

    this.sunRiseHeight = sunRiseHeight;

    this.c = c;

    this.sun = createShape(ELLIPSE, sunStartPos.x, sunStartPos.y, sunRadian, sunRadian);
    this.sun.setFill(color(255, 255, 0));
    this.sun.setStrokeWeight(0);
  }

  public void update(int durationProgress) {
    float durationProgressPercent = this.getDurationProgressPercentage(durationProgress);
    double sine = Math.sin(PI * durationProgressPercent);
    float currentY = (float)sine * (float)this.sunRiseHeight;
    float currentX = (float)width * durationProgressPercent;

    this.sun.setFill(this.c.getColor(durationProgress));

    this.sun.resetMatrix();
    // * -1 because the zero point of the scene is in the upper left corner!
    this.sun.translate(currentX, currentY * -1);
  }

  private void draw() {
    shape(this.sun);
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
