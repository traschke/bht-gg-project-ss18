class Background {
  private int animationLength;

  Gradient sky;
  Sun sun;

  PShape farGround;

  BackgroundLayer treesLayer1;
  BackgroundLayer treesLayer2;
  BackgroundLayer treesLayer3;
  BackgroundLayer mountainLayer1;
  BackgroundLayer groundLayer;

  public Background(int animationLength) {
    this.animationLength = animationLength;

    color dawnTop = color(89, 11, 89); // Purple
    color dawnBottom = color(0, 0, 0); // Black
    color noonTop = color(125, 185, 232); // Light blue
    color noonBottom = color(30, 87, 153); // Slightly darker light blue
    InterpolatingColor topC = new InterpolatingColor(dawnTop, noonTop, animationLength);
    InterpolatingColor bottomC = new InterpolatingColor(dawnBottom, noonBottom, animationLength);
    this.sky = new Gradient(topC, bottomC, Gradient.Y_AXIS);

    this.sun = new Sun(animationLength, height/5, new PVector(0, height/3), height/4, new InterpolatingColor(color(255, 90, 0), color(255, 255, 0), animationLength));

    this.farGround = createShape(RECT, 0, height*0.5, width, height*0.5);
    this.farGround.setFill(color(255, 0, 0));
    this.farGround.setStroke(false);

    this.treesLayer1 = new BackgroundLayer();
    this.treesLayer1.addObjects(this.generateTrees(100, height/10, height/100, height/2, height/2 + height/16, color(40, 142, 0), 150));
    
    this.treesLayer2 = new BackgroundLayer();
    this.treesLayer2.addObjects(this.generateTrees(50, height/4, height/50, (height/8)*4, (height/8)*5, color(0, 214, 53), 150));
    
    this.treesLayer3 = new BackgroundLayer();
    this.treesLayer3.addObjects(this.generateTrees(10, height, height/25, (height/8)*4, (height/8)*5, color(0, 214, 53), 150));
    
    this.mountainLayer1 = new BackgroundLayer();
    this.mountainLayer1.addObjects(this.generateMountains(25, height/2, height/6, height/8, height/2, color(186, 186, 186), 150));

    this.groundLayer = new BackgroundLayer();
    this.groundLayer.addObject(new Ground(0, int(height * 0.75), width));
    this.groundLayer.addObject(new Ground(width, int(height * 0.75), width));
  }

  public void update(int durationProgress) {
    this.sky.update(durationProgress);
    this.sun.update(durationProgress);
    this.mountainLayer1.move(0.25);
    this.treesLayer1.move(1.0);
    this.treesLayer2.move(2.0);
    this.treesLayer3.move(3.0);
    this.groundLayer.move(5.0);
  }

  public void draw() {
    this.sky.draw();
    this.sun.draw();
    // shape(this.farGround);
    this.mountainLayer1.draw();
    this.treesLayer1.draw();
    this.treesLayer2.draw();
    this.treesLayer3.draw();
    this.groundLayer.draw();
  }

  private int jitterHeight(int height, int jitter) {
    return int(random(height - jitter, height + jitter));
  }

  private color jitterColorBrightness(color c, int jitterBrightness) {
    colorMode(HSB, 255);
    float brightness = brightness(c);
    float jitterBrightnessLow = brightness - jitterBrightness < 0 ? 0 : brightness - jitterBrightness;
    float jitterBrightnessHigh = brightness + jitterBrightness > 255 ? 255 : brightness + jitterBrightness;
    float jitteredBrightness = random(jitterBrightnessLow, jitterBrightnessHigh);
    // println("Brightness        : " + brightness);
    // println("jitteredBrightness: " + jitteredBrightness);
    color jitteredColor = color(hue(c), saturation(c), jitteredBrightness);
    colorMode(RGB, 255);

    return jitteredColor;
  }

  private PVector getRandomPosition(int xLowBound, int xHighBound, int yLowBound, int yHighBound) {
    int x = int(random(xLowBound, xHighBound));
    int y = int(random(yLowBound, yHighBound));

    return new PVector(x, y);
  }

  private ArrayList<IBackgroundObject> generateTrees(int treeCount, int treeHeight, int jitterHeight, int posBoundIn, int posBoundOut, color c, int jitterBrightness) {
    ArrayList<IBackgroundObject> trees = new ArrayList<IBackgroundObject>();
    for (int i = 0; i < treeCount; i++) {
      int jitteredHeight = this.jitterHeight(treeHeight, jitterHeight);
      PVector pos = this.getRandomPosition(0, width, posBoundIn, posBoundOut);
      color jitteredColor = this.jitterColorBrightness(c, jitterBrightness);

      int treeType = Math.round(random(1, 3));
      switch(treeType) {
        case 1:
          trees.add(new Tree01(int(pos.x), int(pos.y), jitteredHeight, jitteredColor));
          break;
        case 2:
          trees.add(new Tree02(int(pos.x), int(pos.y), jitteredHeight, jitteredColor));
          break;
        case 3:
          trees.add(new Tree03(int(pos.x), int(pos.y), jitteredHeight, jitteredColor));
          break;
      }
    }
    return trees;
  }

  private ArrayList<IBackgroundObject> generateMountains(int treeCount, int treeHeight, int jitterHeight, int posBoundIn, int posBoundOut, color c, int jitterBrightness) {
    ArrayList<IBackgroundObject> trees = new ArrayList<IBackgroundObject>();
    for (int i = 0; i < treeCount; i++) {
      int jitteredHeight = this.jitterHeight(treeHeight, jitterHeight);
      PVector pos = this.getRandomPosition(0, width, posBoundIn, posBoundOut);
      color jitteredColor = this.jitterColorBrightness(c, jitterBrightness);

      int treeType = Math.round(random(1, 3));
      switch(treeType) {
        case 1:
          trees.add(new Mountain01(int(pos.x), int(pos.y), jitteredHeight, jitteredColor));
          break;
        case 2:
          trees.add(new Mountain02(int(pos.x), int(pos.y), jitteredHeight, jitteredColor));
          break;
      }
    }
    return trees;
  }
}
