/**
 * This is a simple sound file player. Use the mouse position to control playback
 * speed, amplitude and stereo panning.
 */

import processing.sound.*;
import processing.video.*;

Capture video;
int interestIndex = 0;
int count=0;
float avgX=0;
float avgY=0;
color interestColor;

SoundFile soundfile;

void setup() {
  size(640, 480,FX2D);
  background(255);

  // Load a soundfile
  soundfile = new SoundFile(this, "vibraphon.aiff");

  // These methods return useful infos about the file
  println("SFSampleRate= " + soundfile.sampleRate() + " Hz");
  println("SFSamples= " + soundfile.frames() + " samples");
  println("SFDuration= " + soundfile.duration() + " seconds");

  // Play the file in a loop
  soundfile.loop();
  
   video = new Capture(this, width, height);
  video.start();  
  noStroke();
  smooth();
}      


void draw() {
  // Map mouseX from 0.25 to 4.0 for playback rate. 1 equals original playback speed,
  // 2 is twice the speed and will sound an octave higher, 0.5 is half the speed and
  // will make the file sound one ocative lower.
  float playbackSpeed = map(avgY, 0, height, 0.25, 4.0);
  soundfile.rate(playbackSpeed);

  // Map mouseY from 0.2 to 1.0 for amplitude
  float amplitude = map(mouseY, 0, width, 0.2, 1.0);
  soundfile.amp(amplitude);

  // Map mouseY from -1.0 to 1.0 for left to right panning
  float panning = map(avgX, 0, width, -1.0, 1.0);
  soundfile.pan(panning);
  trackColor();
}

void trackColor(){
if (video.available()) {
    video.read();
    image(video, 0, 0, width, height); // Draw the webcam video onto the screen
     video.loadPixels();
    int index = 0;
    for (int y = 0; y < video.height; y++) {
      for (int x = 0; x < video.width; x++) {
        
        
        if(mousePressed){
          interestIndex=mouseX + mouseY*width;
          interestColor = video.pixels[interestIndex];
        }
        PVector c = new PVector( red(video.pixels[index]),green(video.pixels[index]),blue(video.pixels[index]));
        PVector c2 = new PVector(red(interestColor),green(interestColor),blue(interestColor));
        if (c.dist(c2) < 50) {
          stroke(255,0,0,100);
          point(x,y);
          avgY += y;
          avgX += x;
          count++;
        }
        index++;
      }
    }
    if(count>0){
    avgX=avgX/count;
    avgY=avgY/count;
    }
    count=0;
    fill(interestColor,200);
    stroke(0);
    strokeWeight(5);
    ellipse(avgX, avgY, 20, 20);
  }

}
