import java.awt.Robot;
import java.awt.MouseInfo;
import java.awt.Point;


float pos_x = 0.0f;
float pos_y = 0.0f;
float alfa = 0.0f;
float wind_x_offset = 10.0f;
float wind_y_offset = 35.0f;
float windowPosX = 0.0f;
float windowPosY = 0.0f;
boolean pause = true;
color active = color(50,55,100);
color inactive = color (50);
color backgroundColor = color(200);
PImage arrowKey;
PImage moon;
PImage star;
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
  surface.setTitle("Mouse Keeper");
  cursor(star);
}

void settings(){
 size(350,350, P2D); //need P2D because of a stupid bug about pixel density
  PJOGL.setIcon("data/icon.ico");
  smooth();
  arrowKey = loadImage("data/lclick.png");
  moon = loadImage("data/moon.png");
  star = loadImage("data/star.png");
}

void draw(){
  background(backgroundColor);
  update();
  show();
}


void mousePressed(){
  pause = !pause;
  if(!pause){
    updateWindowPosition();
  }
}


void update(){
  if(!pause){
    pos_x = (50 * cos(alfa)) + width/2;
    pos_y = (50 * sin(alfa)) + height/2;
    alfa += increment;
    rob.mouseMove((int)(windowPosX + pos_x), (int)(windowPosY + pos_y));
  }
  
}

void updateWindowPosition(){
  Point mpoint = MouseInfo.getPointerInfo().getLocation();
  windowPosX = (float) mpoint.getX() - mouseX;
  windowPosY = (float) mpoint.getY() - mouseY;
}

void show(){
  imageMode(CORNER);
  image(arrowKey,10,height - 30, 30,30);
  fill(0);
  textSize(15);
  text(": right click or pad-click to start/pause",45,height - 10);
  updateColor();
  strokeWeight(3);
  stroke(50);
  ellipse(width/2,height/2, 230,230);
  imageMode(CENTER);
  image(moon,width/2, height/2, 80,80);
}

void updateColor(){
  if(!pause){
    fill(active);
  }else{
    fill(inactive);
  }
}
