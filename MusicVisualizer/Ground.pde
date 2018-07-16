class Ground extends BackgroundObject {
  public Ground(int x, int y, int groundWidth) {
    super(loadShape("ground.svg"), x, y, groundWidth, 576.973, 84.932);
    println("Created ground at " + x + ", " + y);
  }
}
