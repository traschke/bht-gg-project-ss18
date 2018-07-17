class Tree03 extends BackgroundObject {
  public Tree03(int x, int y, int treeHeight, color c) {
    super(loadShape("tree03.svg"), x, y, treeHeight, 94.719002, 99.714996, c);
    println("Created tree03 at " + x + ", " + y);
  }
}
