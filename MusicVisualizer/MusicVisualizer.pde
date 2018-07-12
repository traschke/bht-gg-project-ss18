import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;

Player player;

int lastBeat;

void setup()
{
  size(1024, 576, P3D);
  // fullScreen(P3D);

  player = new Player(width/4, height, Math.round(height/12.5), Math.round(height/12.5), height/2, 175);

  minim = new Minim(this);
  song = minim.loadFile("levitation.mp3");
  // song.cue(15000);
  song.play();

  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  beat.detectMode(BeatDetect.SOUND_ENERGY);
  // beat.detectMode(BeatDetect.FREQ_ENERGY);
  beat.setSensitivity(200);
}

void draw()
{
  background(0);

  beat.detect(song.mix);

  if (beat.isOnset()) {
    int beatDelta = millis() - lastBeat;
    lastBeat = millis();
    println("beatDelta: "+beatDelta);
    player.jump();
  }

  player.draw();
}
