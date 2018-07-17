import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;

Background background;

Player player;

int lastBeat;

void setup()
{
  size(1024, 576, P2D);
  // fullScreen(P2D);

  minim = new Minim(this);
  // song = minim.loadFile("levitation.mp3");
  song = minim.loadFile("levitation30s.mp3");
  // song.cue(15000);
  song.play();

  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  beat.detectMode(BeatDetect.SOUND_ENERGY);
  // beat.detectMode(BeatDetect.FREQ_ENERGY);
  beat.setSensitivity(200);

  player = new Player(width/4, int(height * 0.89), Math.round(height/12.5), Math.round(height/12.5), height/2, 175);

  background = new Background(song.length());
}

void draw()
{
  background(0);

  beat.detect(song.mix);

  background.update(song.position());
  background.draw();

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
