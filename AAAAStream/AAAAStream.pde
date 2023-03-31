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
  letterA.rotateZ(20);
}


void draw(){
  background(48, 25, 52);
  float ampValue = amp.analyze();
  speed = map(ampValue, 0, 1, 5, 60);
  timeInterval = int(map(ampValue, 0, 1, 100, 2));
  if(millis() >= time + timeInterval){
   time = millis();
   movingLetters.add(new movingLetter(width/2, 0, width/2 * -1));
   
  }
  
  
  
  //println("AAA");
  moveAllLetters();
  displayLetters();
  removeLetters();
}

class movingLetter{
  float x;
  float y;
  float z;
  
  movingLetter( float ex, float why, float zee){
    x = ex;
    y = why;
    z = zee;
    
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
      
      for(int tempX = 0; tempX < width; tempX += 100){
        shape(letterA, tempX, y);
      }
      
      
      
     
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
