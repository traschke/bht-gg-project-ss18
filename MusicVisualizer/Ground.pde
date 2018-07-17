class Ground extends BackgroundObject {
  public Ground(int x, int y, int groundWidth) {
    super(loadShape("ground.svg"), x, y, groundWidth, 576.39001, 84.931999);
    println("Created ground at " + x + ", " + y);
  }
}
