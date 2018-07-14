import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;

Sun sun;
Player player;

int lastBeat;

void setup()
{
  size(1024, 576, P3D);
  // surface.setResizable(true);
  // fullScreen(P3D);

  minim = new Minim(this);
  song = minim.loadFile("levitation30s.mp3");
  // song.cue(15000);
  song.play();

  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  beat.detectMode(BeatDetect.SOUND_ENERGY);
  // beat.detectMode(BeatDetect.FREQ_ENERGY);
  beat.setSensitivity(200);

  player = new Player(width/4, height, Math.round(height/12.5), Math.round(height/12.5), height/2, 175);
  sun = new Sun(song.length(), height/5, new PVector(0, height/3), height/4, color(255, 255, 0), color(255, 90, 0));
}

void draw()
{
  background(0);

  beat.detect(song.mix);

  sun.draw(song.position());

  if (beat.isOnset()) {
    int beatDelta = millis() - lastBeat;
    lastBeat = millis();
    // println("beatDelta: "+beatDelta);
    player.jump();
  }

  player.draw();

  showFps();
}

public void showFps() {
  // display framerate & pixel size
  text(nf(frameRate, 2, 1) + " fps", 10, 30);
  text(width + "x" + height + " pixels", 10, 45);
}
