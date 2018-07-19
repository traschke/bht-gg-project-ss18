class BackgroundLayer {
  ArrayList<BackgroundObject> bgObjects;

  public BackgroundLayer() {
    this.bgObjects = new ArrayList<BackgroundObject>();
  }

  public void addObject(BackgroundObject obj) {
    this.bgObjects.add(obj);
  }

  public void addObjects(ArrayList<BackgroundObject> objs) {
    this.bgObjects.addAll(objs);

    for (BackgroundObject bgo : this.bgObjects) {
      println(bgo.getYPos());
    }
    println("#######");
  }

  public void move(int currentMillis, float speed) {
    for(BackgroundObject bgObject : this.bgObjects) {
      bgObject.move(currentMillis, speed);
    }
  }

  public void draw() {
    for(BackgroundObject bgObject : this.bgObjects) {
      bgObject.draw();
    }
  }
}
