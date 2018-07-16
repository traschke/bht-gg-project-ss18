class Background {
  BackgroundLayer treesLayer1;
  BackgroundLayer treesLayer2;
  BackgroundLayer mountainLayer1;

  public Background() {
    this.treesLayer1 = new BackgroundLayer();
    this.treesLayer1.addObjects(this.generateTrees(100, height/10, height/100, height/2, height/2 + height/16, color(40, 142, 0), 150));
    this.treesLayer2 = new BackgroundLayer();
    this.treesLayer2.addObjects(this.generateTrees(20, height/4, height/50, (height/8)*4, (height/8)*5, color(0, 214, 53), 150));
    this.mountainLayer1 = new BackgroundLayer();
    this.mountainLayer1.addObjects(this.generateMountains(25, height/2, height/6, height/8, height/2, color(186, 186, 186), 150));
  }

  private void update() {
    this.treesLayer1.move(1.0);
    this.treesLayer2.move(2.0);
    this.mountainLayer1.move(0.25);
  }

  public void draw() {
    this.update();
    this.mountainLayer1.draw();
    this.treesLayer1.draw();
    this.treesLayer2.draw();
  }

  private ArrayList<IBackgroundObject> generateTrees(int treeCount, int treeHeight, int jitterHeight, int posBoundIn, int posBoundOut, color c, int jitterBrightness) {
    ArrayList<IBackgroundObject> trees = new ArrayList<IBackgroundObject>();
    for (int i = 0; i < treeCount; i++) {
      int jitteredHeight = int(random(treeHeight - jitterHeight, treeHeight + jitterHeight));
      int x = int(random(0, width));
      int y = int(random(posBoundIn, posBoundOut));

      colorMode(HSB, 255);
      float brightness = brightness(c);
      float jitterBrightnessLow = brightness - jitterBrightness < 0 ? 0 : brightness - jitterBrightness;
      float jitterBrightnessHigh = brightness + jitterBrightness > 255 ? 255 : brightness + jitterBrightness;
      float jitteredBrightness = random(jitterBrightnessLow, jitterBrightnessHigh);
      // println("Brightness        : " + brightness);
      // println("jitteredBrightness: " + jitteredBrightness);
      color jitteredColor = color(hue(c), saturation(c), jitteredBrightness);
      colorMode(RGB, 255);

      trees.add(new Tree(x, y, jitteredHeight, jitteredColor));
    }
    return trees;
  }

  private ArrayList<IBackgroundObject> generateMountains(int treeCount, int treeHeight, int jitterHeight, int posBoundIn, int posBoundOut, color c, int jitterBrightness) {
    ArrayList<IBackgroundObject> trees = new ArrayList<IBackgroundObject>();
    for (int i = 0; i < treeCount; i++) {
      int jitteredHeight = int(random(treeHeight - jitterHeight, treeHeight + jitterHeight));
      int x = int(random(0, width));
      int y = int(random(posBoundIn, posBoundOut));

      colorMode(HSB, 255);
      float brightness = brightness(c);
      float jitterBrightnessLow = brightness - jitterBrightness < 0 ? 0 : brightness - jitterBrightness;
      float jitterBrightnessHigh = brightness + jitterBrightness > 255 ? 255 : brightness + jitterBrightness;
      float jitteredBrightness = random(jitterBrightnessLow, jitterBrightnessHigh);
      // println("Brightness        : " + brightness);
      // println("jitteredBrightness: " + jitteredBrightness);
      color jitteredColor = color(hue(c), saturation(c), jitteredBrightness);
      colorMode(RGB, 255);

      trees.add(new Mountain(x, y, jitteredHeight, jitteredColor));
    }
    return trees;
  }
}
