class Animation {
  protected int animationLength;

  public Animation(int animationLength) {
    this.animationLength = animationLength;
  }

  protected float getAnimationProgressPercentage(int animationProgress) {
    return (float)animationProgress / (float)this.animationLength;
  }
}
