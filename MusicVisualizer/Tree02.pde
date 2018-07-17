class Tree02 extends BackgroundObject {
  public Tree02(int x, int y, int treeHeight, color c) {
    super(loadShape("tree02.svg"), x, y, treeHeight, 67.491997, 100.0, c);
    println("Created tree02 at " + x + ", " + y);
  }
}
