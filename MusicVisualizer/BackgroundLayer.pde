class BackgroundLayer {
  ArrayList<IBackgroundObject> bgObjects;

  public BackgroundLayer() {
    this.bgObjects = new ArrayList<IBackgroundObject>();
  }

  public void addObject(IBackgroundObject obj) {
    this.bgObjects.add(obj);
  }

  public void addObjects(ArrayList<IBackgroundObject> objs) {
    this.bgObjects.addAll(objs);
  }

  public void move(float speed) {
    for(IBackgroundObject bgObject : this.bgObjects) {
      bgObject.move(speed);
    }
  }

  public void draw() {
    for(IBackgroundObject bgObject : this.bgObjects) {
      bgObject.draw();
    }
  }
}
