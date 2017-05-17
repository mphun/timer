//Program by Jeremy Blum
//www.jeremyblum.com
//Give you the temperature

import processing.serial.*;
Serial port;

int time=0;
int stop = 0;
int pause = 0;
int pausestart = 0;
int pauseend = 0;
String rfidtest = "test";

String name = "name";
String input = "";


PFont font;

void setup()
{
  size(800,800);
  port = new Serial(this, "COM3", 9600);
  port.bufferUntil('.'); 
  //font = loadFont("AgencyFB-Bold-200.vlw");
  font = loadFont("Verdana-48.vlw");
  textFont(font);
}

void draw()
{
  background(0,0,0);
  if ( stop == 0 ){
     time = millis() - pause;
  }
  
  textAlign(LEFT);
  textSize(100);
  fill(46, 209, 2);
  fill(0, 102, 153);
  textSize(40);
  text("input: ", 10, 780);
  text(input, 140, 780);
  
  timerDraw(name, time, 0);
 // timerDraw(name, time, 1); 
 // timerDraw(name, time, 2); 
  text(rfidtest, 480, 300); 
  
}

void keyPressed() {
  if (key == '\n') {
    name = input;
    input = "";
  }
 else{ 
  if (key == ' ') {
    if ( stop == 0 ){
       stop = 1; 
       pausestart = millis();
    }
    else{
       stop = 0; 
       //pauseend = millis() - pausestart;
       //pause = pause + pauseend;
       pause = pause + (millis() - pausestart);
    }
  } 
  else{
    if (input.length() < 5 ){
      input = input + key;
    }
  }
 }
}

void timerDraw(String name, int time, int level)
{
  int nanos = 0;
  int seconds = 0;
  int minutes = 0;
  int row = 100;

  row = row + ( 90 * level );
  nanos = time % 100;
  seconds = time/1000 % 60;
  minutes = time/60000;
  
  textAlign(LEFT);
  textSize(100);
  fill(46, 209, 2);
  text(name, 10, row);

  if ( minutes < 10 ){
     text("0", 360, row);
  }
  if ( seconds < 10 ){
     text("0", 500, row);
  }
  
  textSize(100);
  fill(46, 209, 2);
  textAlign(RIGHT);
  text(minutes, 480, row);  
  text(":", 515, row - 10);    
  text(seconds, 630, row);    
  text(".", 660, row - 7);      
  text(nanos, 785, row);   
}

void serialEvent (Serial port)
{
  rfidtest = port.readStringUntil('\n');
}


