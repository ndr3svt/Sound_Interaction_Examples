import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class oscToLiveAbleton extends PApplet {



  
OscP5 oscP5;
NetAddress myRemoteLocation;
public void setup(){

	
	oscP5 = new OscP5(this,12000);
	myRemoteLocation = new NetAddress("127.0.0.1",3000);
}
public void draw(){
	background(0);
	fill(255);
	if(mousePressed){
		text("sending", 10,10);
	}
}

public void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");
  
  myMessage.add(map(mouseX,0,width,-1.0f,1.0f)); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}
  public void settings() { 	size(800,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "oscToLiveAbleton" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
