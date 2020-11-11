import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;
void setup(){

	size(800,400);
	oscP5 = new OscP5(this,12000);
	myRemoteLocation = new NetAddress("127.0.0.1",3000);
}
void draw(){
	background(0);
	fill(255);
	if(mousePressed){
		text("sending", 10,10);
	}
}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");
  
  myMessage.add(map(mouseX,0,width,-1.0,1.0)); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}