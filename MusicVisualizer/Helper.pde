class Helper {
  public PVector getRandomPosition(int xLowBound, int xHighBound, int yLowBound, int yHighBound) {
    int x = int(random(xLowBound, xHighBound));
    int y = int(random(yLowBound, yHighBound));

    return new PVector(x, y);
  }

  public color jitterColorBrightness(color c, int jitterBrightness) {
    colorMode(HSB, 255);
    float brightness = brightness(c);
    float jitterBrightnessLow = brightness - jitterBrightness < 0 ? 0 : brightness - jitterBrightness;
    float jitterBrightnessHigh = brightness + jitterBrightness > 255 ? 255 : brightness + jitterBrightness;
    float jitteredBrightness = random(jitterBrightnessLow, jitterBrightnessHigh);
    color jitteredColor = color(hue(c), saturation(c), jitteredBrightness);
    colorMode(RGB, 255);

    return jitteredColor;
  }

  public int jitterHeight(int height, int jitter) {
    return int(random(height - jitter, height + jitter));
  }
}
