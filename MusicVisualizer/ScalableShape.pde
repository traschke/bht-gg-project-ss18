class ScalableShape {
  protected PShape shape;
  protected PVector pos;
  protected PVector scale;

  public ScalableShape(PShape shape, float x, float y, float w, float h) {
    this.shape = shape;
    this.pos = new PVector(x, y);
    this.scale = new PVector(w/shape.width, h/shape.height);
  }

  public PVector getScaledPos() {
    return new PVector(this.pos.x / this.scale.x, this.pos.y / this.scale.y - this.shape.height);
  }

  public PVector scaleVector(PVector vector) {
    return new PVector(vector.x / this.scale.x, vector.y / this.scale.y);
  }
}
