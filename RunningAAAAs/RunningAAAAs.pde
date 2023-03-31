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
void setup(){
  size(1000, 1000);
  
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  in.start();
  fft.input(in);
  letterA = loadShape("data/A.svg");
  letterA.scale(0.7);
  
}


void draw(){
  background(48, 25, 52);
  fft.analyze(spectrum);
  
  for(int i = 0; i < bands; i++){
    float y = height / (i + 1);
    sum[i] += (fft.spectrum[i] - sum[i]) * smoothingFactor;
    if(spectrum[i] > 0.1){
      movingLetter tempLetter = new movingLetter(y);
      movingLetters.add(tempLetter);
    }
    
    
  }
  //println("AAA");
  moveAllLetters();
  displayLetters();
}

class movingLetter{
  float x;
  float y;
  
  movingLetter( float why){
    x = 0;
    y = why;
    
  }
  
  void move(){
    x += speed;
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
      
      shape(letterA, x, y);
      
      
     
    }
  
}
