class Mountain extends BackgroundObject {
  public Mountain(int x, int y, int mountainHeight, color c) {
    super(loadShape("mountain01.svg"), x, y, mountainHeight, 79.232422, 54.289078, c);
    println("Created mountain01 at " + x + ", " + y);
  }
}
