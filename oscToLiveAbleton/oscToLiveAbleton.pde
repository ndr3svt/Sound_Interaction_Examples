import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
float pan=0.0;
float vol = 0.0;
boolean learnA, learnB;
void setup() {

  size(800, 400, FX2D);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 3000);
}
void draw() {
  background(0);
  fill(255);
  textAlign(CENTER);
  text("while pressed, move the mouse around the screen", width/2, height/2);
  if (mousePressed) {
    // sends the message for panning
    if (!learnB) {
      sendMessageA();
      text("sending pan mssg", 150, 30);
    }
    // sends the message to control the volume
    if (!learnA) {
      sendMessageB();
      text("sending vol mssg", 150, 50);
    }
    
  }
  fill(255,0,0);
  if(learnA){
    text("Live ableton is learning from A" , 150,80);
   
  }
  if(learnB){
    text("Live ableton is learning from B" , 150, 100);
  }
  
  fill(0,0,255);
  rect(150,280,map(vol,-0.5,1,0,100),20);
  rect(150,250,pan*100,20);
}
// panning
void sendMessageA() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/toLiveA");
  pan = map(mouseX, 0, width, -1.0, 1.0);
  myMessage.add(pan); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}

// volume
void sendMessageB() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/toLiveB");
  vol = map(mouseY, 0, height, 1.0, -0.5);
  myMessage.add(vol); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}

void keyPressed() {
  if (key=='a' || key == 'A') {
    learnA = !learnA;
  }
  if (key == 'b' || key == 'B') {
    learnB = !learnB;
  }
}
