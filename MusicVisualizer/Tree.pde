class Tree implements IBackgroundObject {
  private PShape treeShape;
  private float rx;
  private float ry;
  private float treeWidth = 453.53192;
  private float treeHeight = 650.79999;

  public Tree(int x, int y, int treeHeight, color c) {
    float aspectRatio = this.treeWidth / this.treeHeight;
    this.treeHeight = treeHeight;
    this.treeWidth = aspectRatio * treeHeight;
    this.rx = x;
    this.ry = y;
    this.treeShape = loadShape("tree.svg");
    this.treeShape.setFill(c);
    this.treeShape.setStrokeWeight(0);
    println("Created tree at " + x + ", " + y);
  }

  public void move(float step) {
    rx -= step;

    if (rx <= 0 - this.treeWidth) {
      rx = width;
    }
  }

  public void draw() {
    shape(this.treeShape, rx, ry, this.treeWidth, this.treeHeight);
  }
}
