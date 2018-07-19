import java.util.Collections;

class Background {
  private int animationLength;

  Gradient sky;
  Sun sun;

  PShape farGround;

  BackgroundLayer treesLayer1;
  BackgroundLayer treesLayer1p5;
  BackgroundLayer treesLayer2;
  BackgroundLayer treesLayer3;
  BackgroundLayer mountainLayer1;
  BackgroundLayer groundLayer;

  float baseSpeed = 0.3;

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

    this.farGround = createShape(RECT, 0, height*0.50, width, height*0.50);
    this.farGround.setFill(color(169, 124, 80));
    this.farGround.setStroke(false);

    this.treesLayer1 = new BackgroundLayer();
    this.treesLayer1.addObjects(this.generateTrees(64, int(height*0.1), int(height*0.01), int(height*0.55), int(height*0.60), color(40, 142, 0), 150));
    
    this.treesLayer1p5 = new BackgroundLayer();
    this.treesLayer1p5.addObjects(this.generateTrees(48, int(height*0.15), int(height*0.05), int(height*0.60), int(height*0.65), color(0, 214, 53), 150));
    

    this.treesLayer2 = new BackgroundLayer();
    this.treesLayer2.addObjects(this.generateTrees(32, int(height*0.25), int(height*0.10), int(height*0.7), int(height*0.8), color(0, 214, 53), 150));
    
    this.treesLayer3 = new BackgroundLayer();
    this.treesLayer3.addObjects(this.generateTrees(4, int(height*0.75), int(height*0.15), int(height*0.85), int(height*0.90), color(0, 214, 53), 150));
    
    this.mountainLayer1 = new BackgroundLayer();
    this.mountainLayer1.addObjects(this.generateMountains(16, int(height*0.30), int(height*0.15), int(height*0.53), int(height*0.55), color(186, 186, 186), 150));

    this.groundLayer = new BackgroundLayer();
    this.groundLayer.addObject(new Ground(0, int(height * 0.75), width));
    this.groundLayer.addObject(new Ground(width, int(height * 0.75), width));
  }

  public void update(int durationProgress) {
    this.sky.update(durationProgress);
    this.sun.update(durationProgress);
    this.mountainLayer1.move(durationProgress, this.baseSpeed / 32);
    this.treesLayer1.move(   durationProgress, this.baseSpeed / 16);
    this.treesLayer1p5.move( durationProgress, this.baseSpeed / 8);
    this.treesLayer2.move(   durationProgress, this.baseSpeed / 4);
    this.treesLayer3.move(   durationProgress, this.baseSpeed / 2);
    this.groundLayer.move(   durationProgress, this.baseSpeed);
  }

  public void draw() {
    this.sky.draw();
    this.sun.draw();
    shape(this.farGround);
    this.mountainLayer1.draw();
    this.treesLayer1.draw();
    this.treesLayer1p5.draw();
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

  private ArrayList<BackgroundObject> generateTrees(int treeCount, int treeHeight, int jitterHeight, int posBoundIn, int posBoundOut, color c, int jitterBrightness) {
    ArrayList<BackgroundObject> trees = new ArrayList<BackgroundObject>();
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

    Collections.sort(trees);

    

    return trees;
  }

  private ArrayList<BackgroundObject> generateMountains(int treeCount, int treeHeight, int jitterHeight, int posBoundIn, int posBoundOut, color c, int jitterBrightness) {
    ArrayList<BackgroundObject> trees = new ArrayList<BackgroundObject>();
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
