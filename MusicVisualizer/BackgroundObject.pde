abstract class BackgroundObject extends ScalableShape implements Comparable<BackgroundObject> {
  private int lastMillis;

  public BackgroundObject(PShape shape, int x, int y, int size, int sizeType) {
    super(shape, x, y, size, sizeType);
  }

  public BackgroundObject(PShape shape, int x, int y, int size, int sizeType, color c) {
    super(shape, x, y, size, sizeType);
    this.shape.setFill(c);
  }

  public void move(int currentMillis, float speed) {
    int deltaMillis = currentMillis - this.lastMillis;
    this.lastMillis = currentMillis;
    this.pos.set(this.pos.x - deltaMillis * speed, this.pos.y);
    if (this.pos.x <= 0 - this.getScaledSize().x) {
      this.pos.set(width, this.pos.y);
    }
  }

  public void draw() {
    PVector scaledPos = this.getScaledPos();
    pushMatrix();
    scale(this.scale.x, this.scale.y);
    translate(scaledPos.x, scaledPos.y);
    shape(this.shape);
    popMatrix();
  }

  @Override
  public int compareTo(BackgroundObject bgObj) {
    Float f1 = Float.valueOf(this.getPos().y);
    Float f2 = Float.valueOf(bgObj.getPos().y);
    return f1.compareTo(f2);
  }
}
