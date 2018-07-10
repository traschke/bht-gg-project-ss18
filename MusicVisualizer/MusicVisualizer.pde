/**
  * This sketch demonstrates how to use the BeatDetect object song SOUND_ENERGY mode.<br />
  * You must call <code>detect</code> every frame and then you can use <code>isOnset</code>
  * to track the beat of the music.
  * <p>
  * This sketch plays an entire song, so it may be a little slow to load.
  * <p>
  * For more information about Minim and additional features, 
  * visit http://code.compartmental.net/minim/
  */
  
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;

float eRadius;
color eColor;

void setup()
{
  size(1024, 576, P3D);
  // fullScreen(P3D);

  minim = new Minim(this);
  song = minim.loadFile("levitation.mp3");
  song.cue(15000);
  song.play();

  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  beat.detectMode(BeatDetect.SOUND_ENERGY);
  // beat.detectMode(BeatDetect.FREQ_ENERGY);
  beat.setSensitivity(200);
  
  ellipseMode(RADIUS);
  eRadius = height/10;
  eColor = color(random(0, 255), random(0, 255), random(0, 255), 60);

}

void draw()
{
  background(0);

  beat.detect(song.mix);

  float a = map(eRadius, height/10, height/2, 60, 255);

  if (beat.isOnset()) {
    eRadius = height/2;
    println("Onset: " + song.position());
    eColor = color(random(0, 255), random(0, 255), random(0, 255), a);
  } else {
    eColor = color(red(eColor), green(eColor), blue(eColor), a);
  }

  fill(eColor);

  ellipse(width/2, height/2, eRadius, eRadius);
  
  eRadius *= 0.95;
  if ( eRadius < height/10 ) {
    eRadius = height/10;
  }
}
