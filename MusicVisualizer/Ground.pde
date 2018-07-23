class Ground extends BackgroundObject {
  public Ground(int x, int y, int groundWidth) {
    super(loadShape("ground.svg"), x, y, groundWidth, ScalableShape.TYPE_WIDTH);
  }
}
