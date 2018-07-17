class Gradient {
  public static final int Y_AXIS = 1;
  public static final int X_AXIS = 2;

  private PGraphics image;

  private color c1;
  private color c2;

  private int axis;

  public Gradient() {
    this.image = createGraphics(width, height, P2D);
  }

  public Gradient(color c1, color c2, int axis) {
    this();

    this.c1 = c1;
    this.c2 = c2;

    this.axis = axis;
  }

  public void draw() {
    setGradient(0, 0, width, height, this.c1, this.c2, this.axis);

    image(this.image, 0, 0);
  }


  private void setGradient(int x, int y, float w, float h, color c1, color c2, int axis) {
    this.image.beginDraw();
    this.image.noFill();

    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        this.image.stroke(c);
        this.image.line(x, i, x+w, i);
      }
    }  
    else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        this.image.stroke(c);
        this.image.line(i, y, i, y+h);
      }
    }
    this.image.endDraw();
  }
}
