/**
 * Color Tracking 
 * by ndr3svt based 
 *
 * Tracks the brightest pixel in a live video signal. 
 */


import processing.video.*;

Capture video;
int interestIndex = 0;
int count=0;
float avgX=0;
float avgY=0;
color interestColor;

void setup() {
  size(640, 480);
  // Uses the default video input, see the reference if this causes an error
  video = new Capture(this, width, height);
  video.start();  
  noStroke();
  smooth();
}

void draw() {
  if (video.available()) {
    video.read();
    image(video, 0, 0, width, height); // Draw the webcam video onto the screen
    video.loadPixels();
    int index = 0;
    for (int y = 0; y < video.height; y++) {
      for (int x = 0; x < video.width; x++) {
        // Get the color stored in the pixel
        
        
        if(mousePressed){
          interestIndex=mouseX + mouseY*width;
          interestColor = video.pixels[interestIndex];
        }
        PVector c = new PVector( red(video.pixels[index]),green(video.pixels[index]),blue(video.pixels[index]));
        PVector c2 = new PVector(red(interestColor),green(interestColor),blue(interestColor));
        // Determine the brightness of the pixel
        //float pixelBrightness = brightness(pixelValue);
        // If that value is brighter than any previous, then store the
        // brightness of that pixel, as well as its (x,y) location
        if (c.dist(c2) < 25) {
  
          avgY += y;
          avgX += x;
          count++;
        }
        index++;
      }
    }
    if(avgX>0 && avgY>0 && count>0){
    avgX=avgX/count;
    avgY=avgY/count;
    }
    count=0;
    // Draw a large, yellow circle at the brightest pixel
    fill(interestColor,100);
    ellipse(avgX, avgY, 200, 200);
  }
}
