class InterpolatingColor {
  private color c1;
  private color c2;

  private int animationLength;

  public InterpolatingColor(color c1, color c2, int animationLength) {
    this.c1 = c1;
    this.c2 = c2;

    this.animationLength = animationLength;
  }

  public color getColor(int animationProgress) {
    float animationProgressPercent = this.getanimationProgressPercentage(animationProgress);
    color currentColor = lerpColor(this.c1, this.c2, (float)Math.sin(animationProgressPercent * PI));
    return currentColor;
  }

  private float getanimationProgressPercentage(int animationProgress) {
    return (float)animationProgress / (float)this.animationLength;
  }
}
