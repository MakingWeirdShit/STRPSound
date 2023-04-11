import processing.sound.*;
AudioIn in;

PShape greenStar, purpleStar;
float rotae = 0;
Amplitude amp;
float scaletje = 0.6;
PImage noisyBackground, programText, humanNature ;
void setup(){
  fullScreen();
  greenStar = loadShape("data/greenStar.svg");
  greenStar.scale(scaletje);
  purpleStar = loadShape("data/purpleStar.svg");
  purpleStar.scale(scaletje);
  //shapeMode(CENTER);
  
  noisyBackground = loadImage("data/NoisyBackground.png");
  programText = loadImage("data/InteractiveProgram1Text.png");
  in = new AudioIn(this, 0);
  in.start();
  amp = new Amplitude(this);
  amp.input(in);
}


void draw(){
  image(noisyBackground, 0, 0);
  float ampValue = amp.analyze();
 
 
  
  drawStar(greenStar, 1700, 900, 0); //bottom star
  drawStar(purpleStar, 1000, 0, 1); //midle star
  drawStar(greenStar, 200, 1000, 0); //top star
  rotae+= map(ampValue, 0, 1, 1, 20);
  
  image(programText, 0, 0);
  
  
}


void drawStar(PShape sheep, float x, float y, int direction){
  pushMatrix();
  translate(x, y);
  pushMatrix();
  shapeMode(CORNERS);
  if(direction == 0){
    rotate(radians(rotae));
  } else{
    rotate(radians(rotae * -1));
  }
  
  shape(sheep, (sheep.width / 2) * -1 * scaletje , (sheep.height /2 ) * -1 * scaletje);
  
  popMatrix();
  popMatrix();
  
  
}

void drawStar(PShape sheep, float x, float y, int direction, float skeel){
  pushMatrix();
  translate(x, y);
  pushMatrix();
  shapeMode(CORNERS);
  if(direction == 0){
    rotate(radians(rotae));
  } else{
    rotate(radians(rotae * -1));
  }
  
  sheep.scale(skeel);
  shape(sheep, (sheep.width / 2) * -1 * scaletje , (sheep.height /2 ) * -1 * scaletje);
  sheep.scale(1/skeel);
  popMatrix();
  popMatrix();
  
  
}
