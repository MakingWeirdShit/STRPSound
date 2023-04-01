import processing.sound.*;
PShape letterA;
FFT fft;
AudioIn in;
int bands = 32;
float smoothingFactor = 0.2;

float[] spectrum = new float[bands];
float[] sum = new float[bands];

float speed = 30;
ArrayList<movingLetter> movingLetters = new ArrayList<movingLetter>();
Amplitude amp;
int timeInterval, time;
void setup(){
  size(1000, 1000);
  
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  in.start();
  fft.input(in);
  amp = new Amplitude(this);
  amp.input(in);
  letterA = loadShape("data/A.svg");
  letterA.scale(0.7);
  time = millis();
  timeInterval = 50;
  blendMode(DIFFERENCE);
}


void draw(){
  background(48, 25, 52);
  float ampValue = amp.analyze();
  if(ampValue > 0.1){
    float randomX = random(width);
    float randomY = random(height);
    
    float tempScale = map(ampValue, 0,1, 0.4 , 10);
    movingLetters.add(new movingLetter(randomX,randomY, tempScale));
  }
  
  
  
  //println("AAA");
  
  displayLetters();
  removeLetters();
}

class movingLetter{
  float x;
  float y;
  float z;
  float scale;
  movingLetter( float ex, float why, float skale){
    x = ex;
    y = why;
    scale = skale;
    
  }
  
  void move(){
    y+= speed;
    z += speed;
  }
}


void moveAllLetters(){
  for(int i = 0; i< movingLetters.size(); i++){
      movingLetter tempMovingLetter = movingLetters.get(i);
      tempMovingLetter.move();
      movingLetters.set(i, tempMovingLetter);
      
      
     
    }
  
}

void displayLetters(){
  for(int i = 0; i< movingLetters.size(); i++){
      float x = movingLetters.get(i).x;
      float y = movingLetters.get(i).y;
      float tempScale = movingLetters.get(i).scale;
     
        letterA.scale(tempScale);
        shape(letterA, x, y);
        letterA.scale(1/tempScale);
      
      
      
      
     
    }
  
}

void removeLetters(){
  for(int i = 0; i< movingLetters.size(); i++){
      float x = movingLetters.get(i).x;
      float y = movingLetters.get(i).y;
      if(x > height * 1.2){
       movingLetters.remove(i); 
      }
    }
  
}
