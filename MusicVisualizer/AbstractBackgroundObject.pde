abstract class AbstractBackgroundObject implements IBackgroudObject {
  private PShape objShape;
  private float rx;
  private float ry;
  private float objWidth = 453.53192;
  private float objHeight = 650.79999;

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
