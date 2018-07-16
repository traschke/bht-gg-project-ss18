class Tree extends BackgroundObject {
  public Tree(int x, int y, int treeHeight, color c) {
    super(loadShape("tree.svg"), x, y, treeHeight, 453.53192, 650.79999, c);
    println("Created tree at " + x + ", " + y);
  }
}
