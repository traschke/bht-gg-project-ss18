import java.util.Collections;

class Background {
  private int animationLength;

  private Gradient sky;
  private Sun sun;
  private Sun sunSet;

  private BackgroundLayer mountainLayer1;

  private PShape farGround;

  // Tree layers, from far to near
  private BackgroundLayer treesLayer1;
  private BackgroundLayer treesLayer2;
  private BackgroundLayer treesLayer3;
  private BackgroundLayer treesLayer4;

  private BackgroundLayer groundLayer;

  private float baseSpeed = 0.3;

  private Helper helper;

  public Background(int animationLength) {
    this.animationLength = animationLength;

    this.helper = new Helper();

    color dawnTop = color(89, 11, 89); // Purple
    color dawnBottom = color(0, 0, 0); // Black
    color noonTop = color(125, 185, 232); // Light blue
    color noonBottom = color(30, 87, 153); // Slightly darker light blue
    InterpolatingColor topC = new InterpolatingColor(dawnTop, noonTop, animationLength);
    InterpolatingColor bottomC = new InterpolatingColor(dawnBottom, noonBottom, animationLength);
    this.sky = new Gradient(topC, bottomC, Gradient.Y_AXIS);

    this.sun = new Sun(0, height*0.5, height*0.2, ScalableShape.TYPE_HEIGHT, height/4, animationLength, new InterpolatingColor(color(255, 90, 0, 0), color(255, 255, 0, 255), animationLength));
    this.sunSet = new Sun(loadShape("sunSet.svg"), 0, height*0.42, height*0.12, ScalableShape.TYPE_HEIGHT, height/4, animationLength, new InterpolatingColor(color(255, 90, 0, 255), color(255, 255, 0, 0), animationLength));

    this.farGround = createShape(RECT, 0, height*0.50, width, height*0.50);
    this.farGround.setFill(color(169, 124, 80));
    this.farGround.setStroke(false);

    this.treesLayer1 = new BackgroundLayer();
    this.treesLayer1.addObjects(this.generateTrees(64, int(height*0.1), int(height*0.01), int(height*0.55), int(height*0.60), color(40, 142, 0), 150));
    
    this.treesLayer2 = new BackgroundLayer();
    this.treesLayer2.addObjects(this.generateTrees(48, int(height*0.15), int(height*0.05), int(height*0.60), int(height*0.65), color(0, 214, 53), 150));

    this.treesLayer3 = new BackgroundLayer();
    this.treesLayer3.addObjects(this.generateTrees(32, int(height*0.25), int(height*0.10), int(height*0.7), int(height*0.8), color(0, 214, 53), 150));
    
    this.treesLayer4 = new BackgroundLayer();
    this.treesLayer4.addObjects(this.generateTrees(4, int(height*0.75), int(height*0.15), int(height*0.85), int(height*0.90), color(0, 214, 53), 150));
    
    this.mountainLayer1 = new BackgroundLayer();
    this.mountainLayer1.addObjects(this.generateMountains(16, int(height*0.30), int(height*0.15), int(height*0.53), int(height*0.55), color(186, 186, 186), 150));

    this.groundLayer = new BackgroundLayer();
    this.groundLayer.addObject(new Ground(0, height, width));
    this.groundLayer.addObject(new Ground(width, height, width));
  }

  public void update(int durationProgress) {
    this.sky.update(durationProgress);
    this.sun.update(durationProgress);
    this.sunSet.update(durationProgress);
    this.mountainLayer1.move(durationProgress, this.baseSpeed / 32);
    this.treesLayer1.move(   durationProgress, this.baseSpeed / 16);
    this.treesLayer2.move(   durationProgress, this.baseSpeed / 8);
    this.treesLayer3.move(   durationProgress, this.baseSpeed / 4);
    this.treesLayer4.move(   durationProgress, this.baseSpeed / 2);
    this.groundLayer.move(   durationProgress, this.baseSpeed);
  }

  public void draw() {
    this.sky.draw();
    this.sunSet.draw();
    this.sun.draw();
    shape(this.farGround);
    this.mountainLayer1.draw();
    this.treesLayer1.draw();
    this.treesLayer2.draw();
    this.treesLayer3.draw();
    this.treesLayer4.draw();
    this.groundLayer.draw();
  }

  private ArrayList<BackgroundObject> generateTrees(int treeCount, int treeHeight, int jitterHeight, int posBoundIn, int posBoundOut, color c, int jitterBrightness) {
    ArrayList<BackgroundObject> trees = new ArrayList<BackgroundObject>();
    for (int i = 0; i < treeCount; i++) {
      int jitteredHeight = this.helper.jitterHeight(treeHeight, jitterHeight);
      PVector pos = this.helper.getRandomPosition(0, width, posBoundIn, posBoundOut);
      color jitteredColor = this.helper.jitterColorBrightness(c, jitterBrightness);

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
      int jitteredHeight = this.helper.jitterHeight(treeHeight, jitterHeight);
      PVector pos = this.helper.getRandomPosition(0, width, posBoundIn, posBoundOut);
      color jitteredColor = this.helper.jitterColorBrightness(c, jitterBrightness);

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

    Collections.sort(trees);
    return trees;
  }
}
