/***
*
*/
class Landscape {
  private int duration;

  private PShape sun;

  private PVector sunBezierA;
  private PVector sunBezierB;
  private PVector sunBezierC;

  public Landscape(int duration, int sunRadian, PVector sunStartPos, int sunPostionMax) {
    println("sunStartPos: "+sunStartPos);
    println("sunPostionMax: "+sunPostionMax);
    this.duration = duration;

    this.sunBezierA = new PVector(0, sunPostionMax);
    this.sunBezierB = new PVector(width/2, 0);
    this.sunBezierC = new PVector(width, sunPostionMax);

    this.sun = createShape(ELLIPSE, sunStartPos.x, sunStartPos.y, sunRadian, sunRadian);
    this.sun.setFill(color(255, 255, 0));
  }

  public void draw(int durationProgress) {
    this.drawSun(durationProgress);
    this.drawTimebar(durationProgress);
  }

  private void drawSun(int durationProgress) {
    float durationProgressPercent = this.getDurationProgressPercentage(durationProgress);
    PVector a = new PVector(this.sunBezierA.x, this.sunBezierA.y);
    PVector b = new PVector(this.sunBezierB.x, this.sunBezierB.y);
    PVector c = new PVector(this.sunBezierC.x, this.sunBezierC.y);

    PVector result = this.bezier(durationProgressPercent, a, b, c);

    this.sun.resetMatrix();
    this.sun.translate(result.x, result.y);
    shape(this.sun);
  }

  private void drawTimebar(int durationProgress) {
    float durationProgressPercent = this.getDurationProgressPercentage(durationProgress);
    float timebarProgressWidth = (float)width * durationProgressPercent;

    PShape timebar = createShape(RECT, 0, 0, timebarProgressWidth, height/50);
    timebar.setStrokeWeight(0);

    shape(timebar);
  }

  private PVector bezier(float t, PVector a, PVector b, PVector c) {
    PVector ab = a.lerp(b, t);
    PVector bc = b.lerp(c, t);
    return ab.lerp(bc, t);
  }

  private float getDurationProgressPercentage(int durationProgress) {
    return (float)durationProgress / (float)this.duration;
  }

}
