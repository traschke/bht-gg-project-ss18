class Mountain01 extends BackgroundObject {
  public Mountain01(int x, int y, int mountainHeight, color c) {
    super(loadShape("mountain01.svg"), x, y, mountainHeight, ScalableShape.TYPE_HEIGHT, c);
  }
}
