import processing.sound.*;

//float angle = 0;
int amountOfLetters = 16;
float radius = 200;
float originalAngle = 0;
float angleStep = 360 / amountOfLetters;
int amountOfCircles = 6;
FFT fft;
AudioIn in;
int bands = 256;
float[] spectrum = new float[bands];
Amplitude amp;
PShape letterA;

void setup(){
  size(1000, 1000);
  letterA = loadShape("data/A.svg");
  in = new AudioIn(this, 0);
  in.start();
  
 
  amp = new Amplitude(this);
  amp.input(in);
  shapeMode(CENTER);
  letterA.scale(0.5);
}


void draw(){
  background(48, 25, 52);
  float ampValue = amp.analyze();
  float newScale = map(ampValue, 0, 0.5, 0.5, 2);
  letterA.scale(newScale);
  translate(width/2, height/2);
  
  for(int i = 1; i <=amountOfCircles; i++){
     for(float angle = originalAngle; angle < originalAngle + 360; angle+= 360/ (i*12)){
    float x = cos(radians(angle)) * (radius * (0.6 * i));
    
    float y = sin(radians(angle)) * (radius * (0.6 * i));
    pushMatrix();
    translate(x, y);
    //rotate(angle / 60);
    shape(letterA, 0, 0);
    popMatrix();
  }
    
  }
 
  
  letterA.scale(1/newScale);
  
  if(ampValue > 0.3){
   originalAngle+= map(ampValue, 0.3, 1, 1, 20); 
   // println(ampValue);
  } else{
   originalAngle += 0.1; 
  }
  
}
