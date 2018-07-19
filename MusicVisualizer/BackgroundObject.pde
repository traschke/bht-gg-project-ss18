abstract class BackgroundObject implements IBackgroundObject, Comparable<BackgroundObject> {
  private PShape objShape;
  private float rx;
  private float ry;
  private float objWidth;
  private float objHeight;

  private int lastMillis;

  public BackgroundObject(PShape objShape, int x, int y, int objHeight, float origWidth, float origHeight, color c) {
    float aspectRatio = origWidth / origHeight;
    this.objHeight = objHeight;
    this.objWidth = aspectRatio * objHeight;

    this.rx = x;
    // Workaround to set the lower corner of the shape
    this.ry = y - this.objHeight;

    this.objShape = objShape;
    this.objShape.setFill(c);
    this.objShape.setStrokeWeight(0);
    // println("Created obj at " + x + ", " + y);
  }

  public BackgroundObject(PShape objShape, int x, int y, int objWidth, float origWidth, float origHeight) {
    float aspectRatio = origHeight / origWidth;
    this.objWidth = objWidth;
    this.objHeight = aspectRatio * objWidth;

    // println("this.objWidth: "+this.objWidth);
    // println("this.objHeight: "+this.objHeight);

    this.rx = x;
    this.ry = y;

    this.objShape = objShape;
    this.objShape.setStrokeWeight(0);
    // println("Created obj at " + x + ", " + y);
  }

  public void move(int currentMillis, float speed) {
    int deltaMillis = currentMillis - this.lastMillis;
    this.lastMillis = currentMillis;
    rx -= deltaMillis * speed;

    if (rx <= 0 - this.objWidth) {
      rx = width;
    }
  }

  protected float getYPos() {
    return this.ry;
  }

  public void draw() {
    shape(this.objShape, rx, ry, this.objWidth, this.objHeight);
  }

  @Override
  public int compareTo(BackgroundObject bgObj) {
    Float f1 = Float.valueOf(this.getYPos());
    Float f2 = Float.valueOf(bgObj.getYPos());
    return f1.compareTo(f2);
  }
}
