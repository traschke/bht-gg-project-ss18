/***
*
*/
class Landscape {
  private int duration;

  private PShape sun;
  private int sunRiseHeight;

  private PShader blurShader;

  public Landscape(int duration, int sunRadian, PVector sunStartPos, int sunRiseHeight) {
    this.duration = duration;

    this.sunRiseHeight = sunRiseHeight;

    this.sun = createShape(ELLIPSE, sunStartPos.x, sunStartPos.y, sunRadian, sunRadian);
    this.sun.setFill(color(255, 255, 0));
    this.sun.setStrokeWeight(0);

    this.blurShader = loadShader("blur.glsl");
  }

  public void draw(int durationProgress) {
    this.drawSun(durationProgress);
    this.drawTimebar(durationProgress);
  }

  private void drawSun(int durationProgress) {
    float durationProgressPercent = this.getDurationProgressPercentage(durationProgress);
    double sine = Math.sin(PI * durationProgressPercent);
    float currentY = (float)sine * (float)this.sunRiseHeight;
    float currentX = (float)width * durationProgressPercent;

    this.sun.resetMatrix();
    // * -1 because the zero point of the scene is in the upper left corner!
    this.sun.translate(currentX, currentY * -1);
    shape(this.sun);
  }

  private void drawTimebar(int durationProgress) {
    float durationProgressPercent = this.getDurationProgressPercentage(durationProgress);
    float timebarProgressWidth = (float)width * durationProgressPercent;

    PShape timebar = createShape(RECT, 0, 0, timebarProgressWidth, height/50);
    timebar.setStrokeWeight(0);

    shape(timebar);
  }

  private PGraphics blurImage(PGraphics src) {
    PGraphics pass1 = createGraphics(height, width);
    PGraphics pass2 = createGraphics(height, width);

    // Applying the blur shader along the vertical direction
    this.blurShader.set("horizontalPass", 0);
    pass1.beginDraw();
    pass1.shader(this.blurShader);
    pass1.image(src, 0, 0);
    pass1.endDraw();

    // Applying the blur shader along the horizontal direction
    this.blurShader.set("horizontalPass", 1);
    pass2.beginDraw();
    pass2.shader(this.blurShader);
    pass2.image(pass1, 0, 0);
    pass2.endDraw();

    return pass2;
  }

  private float getDurationProgressPercentage(int durationProgress) {
    return (float)durationProgress / (float)this.duration;
  }

}
