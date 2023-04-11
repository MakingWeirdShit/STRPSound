//think about incorporating random blinking lightning bolts on screen?

import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 256;
float[] spectrum = new float[bands];
color thatPink, thatGreen, thatLightPink;
int spacing = 10;
int colorCounter = 0;

PShape bolt, miniBolt, boltCircle, thunders;
PShape pinkBolt, greenBolt, whiteBolt;
float scaling = 0.05;
ArrayList<Bolt> lightningBolts = new ArrayList<Bolt>();
float divider = 100;
float noiseDivider = random(10);
float noiseSpeed = random(10);
BeatDetector beatDetector;
BeatDetector bigBeat;

int r = 0;
color pinkpopPink = color(255,62, 150);
color pinkpopGreen = color(155, 209, 158);
color white = color(255, 255, 255);

//strp colors
color strpPurple = color(110, 81, 148);
color strpGreen = color(174, 195, 54);
color strpRed = color(211, 49, 12);
color strpOrange = color(216, 125, 18);

color main, secondaryColor, highlightColor;

int Y_AXIS = 1;
int X_AXIS = 2;

Amplitude amp;

float thirdHeight;
float halfHeight ;
float sixthHeight ;

//adjustments for the gradients work bottom to top, so we have 2 separate ones
float adjustment = 0;
float secondAdjustment= 0 ; //

PImage noisyBackground;


void setup() {
  fullScreen();
  //background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
  thatPink = color(110, 81, 148);// strp purple
  thatGreen = color(174, 195, 54);//strp green
  thatLightPink = color(211, 49, 12); //strp red
  frameRate(30);
  
  bolt = loadShape("data/greenStar.svg");
  pinkBolt = loadShape("data/orangeStar.svg");
  //scale to 0.10 to get the proper ones
  greenBolt = loadShape("data/purpleStar.svg");
  whiteBolt = loadShape("data/redStar.svg");
  
  miniBolt = pinkBolt;
  boltCircle = loadShape("data/greenStar.svg");
  thunders = loadShape("data/greenStar.svg");
  //miniBolt.setFill(color(255, 0, 255));
  //miniBolt.scale(scaling);
  
  beatDetector = new BeatDetector(this);
  beatDetector.input(in);
  
  //amplitude
  amp = new Amplitude(this);
  amp.input(in);
  
  //heights
  thirdHeight = height/3;
  halfHeight = height/2;
  sixthHeight = height/6;
  shapeMode(CENTER);
  rectMode(CENTER);
  
  //beat detection
   bolt = loadShape("data/properStar.svg");
  beatDetector = new BeatDetector(this);
  beatDetector.input(in);
  
  bigBeat = new BeatDetector(this);
  bigBeat.input(in);
  // The sensitivity determines how long the detector will wait after detecting
  // a beat to detect the next one.
  beatDetector.sensitivity(50);
  bigBeat.sensitivity(0);

 noisyBackground = loadImage("data/NoisyBackground.png");
  
}      

void draw() { 
 //background(255);
  //fft.analyze(spectrum);
  //float sum = 0;
  //for(int i = 0; i < bands; i++){
  //// The result of the FFT is normalized
  //// draw the line for frequency band i scaling it up by 5 to get more amplitude.
  ////line(  i *spacing, height, i*spacing, height - spectrum[i]*height*5 );
  ////println(spectrum[i]);
  //sum+= spectrum[i];
  //} 
  
  //float mean = sum /bands;
  //println(mean);
  //float amount = map(mean, 0, 0.010, 0, 1.0);
  //color inbetween = lerpColor(thatPink, thatLightPink, amount);
  //background(inbetween);
  
   if (beatDetector.isBeat()) {
      makeBolts();
     
     
  } else {
    //do nohing
  }
  
  //if(bigBeat.isBeat()){
  //  decideColor();
  //  float miniBoltScale = 1.10;
  //  miniBolt.scale(miniBoltScale);
  //  miniBolt.scale(1/miniBoltScale);
  //}
  
  
  //pinkpopBackground();
  
  image(noisyBackground, 0, 0);
  checkCheer();
  drawBolts();
  updateBolts();
  mainBolt();
  //saveFrame("demo/####.png")
  
}

void getGradientLocations(){
  float ampValue = amp.analyze();
  //when the amplitude on 0 the heights are unchanged, the higher the amplitude gets the more the gradient height rear towards a full pink screen
  if(ampValue<= 0.4){
    adjustment = map(ampValue, 0, 0.4, 0, halfHeight);
    secondAdjustment = 0;
  } else if(ampValue > 0.4){
    adjustment = map(ampValue, 0, 0.4, 0, halfHeight);
    secondAdjustment = map(ampValue,0.400000000001, 0.6, 0, thirdHeight);
  }
  //println(ampValue);
  
}

void checkCheer(){
  float ampValue = amp.analyze();
  if(ampValue> 0.55){
    println("se");
     for(int i = 0; i< lightningBolts.size(); i++){
      Bolt tempBolt = lightningBolts.get(i);
      tempBolt.speed = 100;
      lightningBolts.set(i, tempBolt);
      }
      
      
     
    }
  }


void boltsAround(float boltRadius){
  shapeMode(CENTER);
  float circleScale = map(boltRadius, 300, 400,675, 900);
  
  //shape(boltCircle, width/2, height/2, circleScale, circleScale);
  pushMatrix();
  int x = width/2;
  int y = height/2;
  translate(x, y);
  rotate(radians(r));
   shape(boltCircle, 0, 0, circleScale, circleScale);
   circleScale = map(boltRadius, 300, 400,700, 1200);
   shape(thunders, 0, 0, circleScale, circleScale);
   // shape(boltCircle, -1, -1, circleScale, circleScale);
   r+=1;
   popMatrix();
 
}

void pinkpopBackground(){
  getGradientLocations();
  setGradient(0, 0, width, thirdHeight - secondAdjustment, strpRed, strpOrange,Y_AXIS);
  setGradient(0, int(thirdHeight - secondAdjustment), width, halfHeight- adjustment, strpGreen, strpRed, Y_AXIS);
  setGradient(0, int(thirdHeight + halfHeight - adjustment - secondAdjustment), width, sixthHeight + adjustment + secondAdjustment, strpPurple, strpGreen, Y_AXIS);
}

void mainBolt(){
  
  fill(0);
 
  stroke(255);
  strokeWeight(5);
  //ellipse(width/2, height/2, 300, 300);
  fft.analyze(spectrum);
  float sum = 0;
  for(int i = 0; i < bands; i++){
  /// The result of the FFT is normalized
  //// draw the line for frequency band i scaling it up by 5 to get more amplitude.
  ////line(  i *spacing, height, i*spacing, height - spectrum[i]*height*5 );
  //println(spectrum[i]);
  sum+= spectrum[i];
  } 
  
  float mean = sum /bands;
  
  float frequencyRadius = 300;
  frequencyRadius = map(mean, 0, 0.010, 300, 400);
 boltsAround(frequencyRadius);
  // ellipse(width/2, height/2, frequencyRadius, frequencyRadius);
  //we need the size of the shape to grow based on the live mean of the fft, it grows if the mean gets bigger and gets smaller if the mean gets smaller
  //println("mean", mean);
  float scaleBolt = map(mean, 0, 0.010, 1.0, 1.2);
  float boltWidth, boltHeight;
  boltWidth = map(mean, 0, 0.010, 100, 150);
  boltHeight= map(mean, 0, 0.010, 200, 300);
 // bolt.scale(scaleBolt);
  //shape(bolt, width/2, height/2, boltWidth, boltHeight);
 // bolt.scale(1/scaleBolt);
}

class Bolt{
  float x;
  float y;
  float speed;
  
  Bolt(float inputX, float inputY){
    x = inputX;
    y = inputY;
  }
  
  Bolt(float inputX, float inputY, float speedy){
    x = inputX;
    y = inputY;
    speed = speedy;
  }
  void makeBolts(){
    //add new lightnng bolts into the array list at the bototm of the screen
    for(int i = 0; i<= width; i+= divider){
      
      Bolt tempBolt = new Bolt(i, height);
      lightningBolts.add(tempBolt);
    }
    
  }
  
  void updateBolts(){
    
    for(int i = 0; i<= lightningBolts.size(); i++){
      Bolt tempBolt = lightningBolts.get(i);
      tempBolt.y -=1;
      lightningBolts.set(i, tempBolt);
      if(lightningBolts.get(i).y < 0){
       lightningBolts.remove(i); 
      }
    }
  }
  
  void drawBolts(){
    for(int i = 0; i<= lightningBolts.size(); i++){
      Bolt tempBolt = lightningBolts.get(i);
      
      stroke(0);
      strokeWeight(10);
      shape(bolt, tempBolt.x, tempBolt.y);
    }
  }
  
}

void makeBolts(){
    //add new lightnng bolts into the array list at the bototm of the screen
    float addedNoise = divider * noise(noiseDivider);
    for(float  i = 0; i<= width; i+= addedNoise){
      
      boolean coin = coinflip();
      
      //if(coin){
      //  float addedNoise = divider * noise(noiseDivider);
      //  i+= addedNoise;
      //} else{
      //  float addedNoise = divider * noise(noiseDivider);
      //  i-= addedNoise;
      //}
      
       addedNoise = divider * noise(noiseDivider);
       // i+= addedNoise;
       
      
      float speedy = 60 * noise(noiseSpeed);
      Bolt tempBolt = new Bolt(0, i, speedy);
      lightningBolts.add(tempBolt);
     
       
      noiseSpeed += 0.1;
      noiseDivider += 0.1;
    }
    
  }

void updateBolts(){
    
    for(int i = 0; i< lightningBolts.size(); i++){
      Bolt tempBolt = lightningBolts.get(i);
      
      tempBolt.x += tempBolt.speed;
     
      lightningBolts.set(i, tempBolt);
      if(lightningBolts.get(i).x > width ){
       // println(tempBolt.y, tempBolt.speed);
        
       lightningBolts.remove(i); 
      }
    }
    
  }
  
  void drawBolts(){
    boolean beat = false;
    float miniBoltScale = 1.15;
   if(bigBeat.isBeat()){
    decideColor();
    beat = true;
    
  }
    for(int i = 0; i< lightningBolts.size(); i++){
      Bolt tempBolt = lightningBolts.get(i);
      if(beat){
        miniBolt.scale(miniBoltScale);
        shape(miniBolt, tempBolt.x, tempBolt.y);
    miniBolt.scale(1/miniBoltScale);
      } else{
        shape(miniBolt, tempBolt.x, tempBolt.y);
      }
      
      
     
    }
     
  }
  
  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}

void decideColor(){
  
  //rotate between 3 colors with color counter variable
  
  
  if(colorCounter ==0){
    
    miniBolt = pinkBolt;
  } else if(colorCounter == 1){
    miniBolt = greenBolt;
  } else if(colorCounter == 2){
    
    miniBolt = whiteBolt;
    
  }
  colorCounter++;
  if(colorCounter ==3){
    colorCounter = 0;
  }
  
}


boolean coinflip(){
   float randomNum = random(1);
   if(randomNum <= 0.5){
     return true;
   } else {
     return false;
   }
}
