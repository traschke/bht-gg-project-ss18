abstract class BackgroundObject implements IBackgroundObject {
  private PShape objShape;
  private float rx;
  private float ry;
  private float objWidth;
  private float objHeight;

  public BackgroundObject(PShape objShape, int x, int y, int objHeight, float origWidth, float origHeight, color c) {
    float aspectRatio = origWidth / origHeight;
    this.objHeight = objHeight;
    this.objWidth = aspectRatio * objHeight;

    this.rx = x;
    this.ry = y;
    
    this.objShape = objShape;
    this.objShape.setFill(c);
    this.objShape.setStrokeWeight(0);
    println("Created obj at " + x + ", " + y);
  }

  public void move(float step) {
    rx -= step;

    if (rx <= 0 - this.objWidth) {
      rx = width;
    }
  }

  public void draw() {
    shape(this.objShape, rx, ry, this.objWidth, this.objHeight);
  }
}
