class InterpolatingColor extends Animation {
  private color c1;
  private color c2;

  public InterpolatingColor(color c1, color c2, int animationLength) {
    super(animationLength);
    this.c1 = c1;
    this.c2 = c2;
  }

  public color getColor(int animationProgress) {
    float animationProgressPercent = this.getAnimationProgressPercentage(animationProgress);
    color currentColor = lerpColor(this.c1, this.c2, (float)Math.sin(animationProgressPercent * PI));
    return currentColor;
  }
}
