class ScalableShape {
  public final static int TYPE_WIDTH = 1;
  public final static int TYPE_HEIGHT = 2;

  protected PShape shape;
  protected PVector pos;
  protected PVector scale;

  private ScalableShape(PShape shape, float x, float y) {
    this.shape = shape;
    this.shape.setStrokeWeight(0);
    this.pos = new PVector(x, y);
  }

  public ScalableShape(PShape shape, float x, float y, float w, float h) {
    this(shape, x, y);
    this.scale = new PVector(w/shape.width, h/shape.height);
  }

  public ScalableShape(PShape shape, float x, float y, float size, int sizeType) {
    this(shape, x, y);
    if (sizeType == TYPE_WIDTH) {
      this.scale = new PVector(size / shape.width, size / shape.width);
    } else if (sizeType == TYPE_HEIGHT) {
      this.scale = new PVector(size / shape.height, size / shape.height);
    }
  }

  public PVector getPos() {
    return this.pos;
  }
  public PVector getScaledPos() {
    return new PVector(this.pos.x / this.scale.x, this.pos.y / this.scale.y - this.shape.height);
  }

  public PVector scaleVector(PVector vector) {
    return new PVector(vector.x / this.scale.x, vector.y / this.scale.y);
  }

  public PVector getScaledSize() {
    return new PVector(this.shape.width * this.scale.x, this.shape.height * this.scale.y);
  }
}
