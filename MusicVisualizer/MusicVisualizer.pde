import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
FFT fft;

Background background;
Player player;

int high = 3;
int low = 1;
int threshold = 2;

void setup()
{
  // size(1280, 720, P2D);
  fullScreen(P2D);
  smooth(8);

  minim = new Minim(this);
  song = minim.loadFile("levitation.mp3", 1024);
  // song = minim.loadFile("levitation30s.mp3", 1024);
  // song.cue(15000);

  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  beat.detectMode(BeatDetect.SOUND_ENERGY);
  // beat.detectMode(BeatDetect.FREQ_ENERGY);
  beat.setSensitivity(200);

  // fft = new FFT(song.bufferSize(), song.sampleRate());

  player = new Player(width/4, int(height * 0.8885), Math.round(height/12.5), Math.round(height/12.5), height/2, 175);

  background = new Background(song.length());
  // try {
  //   Thread.sleep(10000);
  // } catch(InterruptedException e) {
  //     System.out.println("got interrupted!");
  // }
  song.play();
}

void update() {
  beat.detect(song.mix);
  // if (beat.isRange(low, high, threshold)) {
  if (song.position() > 16500) {
    if (beat.isOnset()) {
      player.jump();
    }
  }

  background.update(song.position());
  player.update();
}

void draw()
{
  update();

  background(0);

  background.draw();
  player.draw();

  showFps();

  // FFT debug
  // drawSpectrum();
  // drawBeatDetectSpectrum();

  // saveFrame("line-######.png");
}

public void showFps() {
  // display framerate & pixel size
  text(nf(frameRate, 2, 1) + " fps", 10, 30);
  text(width + "x" + height + " pixels", 10, 45);
}

// void keyPressed() {
//   if (key == CODED) {
//     switch (keyCode) {
//       case UP:
//         high++;
//         println("High: " + high);
//         break;
//       case DOWN:
//         if (high - 1 >= 0) {
//           high--;
//         }
//         println("High: " + high);
//         break;
//       case RIGHT:
//         low++;
//         println("Low: " + low);
//         break;
//       case LEFT:
//         if (low - 1 >= 0) {
//           low--;
//         }
//         println("Low: " + low);
//         break;
//     }
//   } else {
//     if (key == 'd') {
//       threshold++;
//       println("Threshold: " + threshold);
//     } else if (key == 'a') {
//       if (threshold - 1 >= 0) {
//         threshold--;
//       }
//       println("Threshold: " + threshold);
//     }
//   }
// }

// public void drawSpectrum() {
//   background(0);
//   stroke(255);
//   fill(255);
  
//   fft.forward(song.mix);

//   int bands = 20;

//   int wii = width / bands;
//   println(fft.getBand(1));  
//   for(int i = 0; i < bands; i++)
//   {
//     rectMode(CORNERS);
//     rect(wii * i, height, (wii * i) + wii, height - fft.getBand(i));
//   }
// }

// public void drawBeatDetectSpectrum() {
//   background(0);
//   stroke(color(255, 0, 0));
//   fill(255);

//   int widdo = width / beat.detectSize();

//   for(int i = 0; i < beat.detectSize(); i++) {
//     if (beat.isOnset(i)) {
//       rectMode(CORNERS);
//       rect(i * widdo, height - 250, (i * widdo) + widdo, height);
//     }
//   }
// }
