/**
 * This is a simple sound file trigger play / stop on mousePressed / mouseReleased
 * by ndr3svt
 */

import processing.sound.*;
float duration;
SoundFile soundfile;
boolean mP = false;
void setup() {
  size(640, 360);
  background(255);

  // Load a soundfile
  soundfile = new SoundFile(this, "vibraphon.aiff");

  // These methods return useful infos about the file
  println("SFSampleRate= " + soundfile.sampleRate() + " Hz");
  println("SFSamples= " + soundfile.frames() + " samples");
  println("SFDuration= " + soundfile.duration() + " seconds");
  duration = soundfile.frames();
  // Play the file in a loop
  //soundfile.loop();
}      


void draw() {
  background(255);
  if(mousePressed && !mP ){
   
    //soundfile.cueFrame(int(random(duration)));
     soundfile.play();
     mP=true;
  }else{
    if(!mousePressed && mP){
      mP=false;
      //soundfile.stop();
    }
  }
  soundfile.frames();
  fill(0);
  if(mP){
    text("sound is playing" , 50,50);
  }else{
    text("sound is not playing" , 50,50);
  }
}
