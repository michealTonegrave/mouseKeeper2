import java.awt.Robot;
import java.awt.MouseInfo;
import java.awt.Point;
import java.awt.Frame;
import processing.awt.PSurfaceAWT;


PVector windowPos;
float pos_x = 0.0f;
float pos_y = 0.0f;
float alfa = 0.0f;
float wind_x_offset = 10.0f;
float wind_y_offset = 35.0f;
boolean pause = true;
color active = color(50,55,100);
color inactive = color (50);
color backgroundColor = color(255);
PImage arrowKey;
static float increment = 0.08f;
static Robot rob;

static{
  try{
    rob = new Robot();
  }catch(Exception e){
    throw new RuntimeException("Cannot create an instance of type Robot: "
                               + e.getMessage());
  }
}


void setup(){
  size(400,400);
  smooth();
  arrowKey = loadImage("keyboard_key_up.png");
}

void draw(){
  updateWindowPosition();
  background(backgroundColor);
  update();
  show();
}

void keyPressed(){
  if(key == CODED && keyCode == UP){
    pause = !pause;
  }  
}

void update(){
  if(!pause){
    pos_x = (100 * cos(alfa)) + width/2;
    pos_y = (100 * sin(alfa)) + height/2;
    alfa += increment;
    PVector mouseVector = PVector.add(windowPos, new PVector(pos_x,pos_y));
    rob.mouseMove((int) mouseVector.x, (int) mouseVector.y);
  }
  
}

void updateWindowPosition(){
  Frame window = ((PSurfaceAWT.SmoothCanvas)((PSurfaceAWT)surface).getNative()).getFrame();
  Point pframe = window.getLocation();
  windowPos = new PVector((float) pframe.getX() + wind_x_offset, (float) pframe.getY()
                          + wind_y_offset);
}

void show(){
  image(arrowKey,0,height - 30, 30,30);
  fill(0);
  textSize(15);
  text(": start/pause",35,height - 10);
  updateColor();
  noStroke();
  ellipse(width/2,height/2, 230,230);
  fill(backgroundColor);
  ellipse(width/2,height/2,70,70);
}

void updateColor(){
  if(!pause){
    fill(active);
  }else{
    fill(inactive);
  }
}
