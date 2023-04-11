import processing.sound.*;

//float angle = 0;
int amountOfLetters = 16;
float radius = 200;
float originalAngle = 0;
float originalNegativeAngle = 0;
float angleStep = 360 / amountOfLetters;
int amountOfCircles = 9;
FFT fft;
AudioIn in;
int bands = 256;
float[] spectrum = new float[bands];
Amplitude amp;
PShape greenStar, purpleStar;
PImage noisyBackground;
BeatDetector beatDetector;
BeatDetector bigBeat;
boolean flip  = true;

void setup() {
  fullScreen();
  greenStar = loadShape("data/greenStar.svg");
  purpleStar = loadShape("data/purpleStar.svg");
  noisyBackground = loadImage("data/NoisyBackground.png");

  in = new AudioIn(this, 0);
  in.start();


  fft = new FFT(this, bands);



  // patch the AudioIn
  fft.input(in);
  beatDetector = new BeatDetector(this);
  beatDetector.input(in);

  amp = new Amplitude(this);
  amp.input(in);
  shapeMode(CENTER);
  greenStar.scale(0.05);
  purpleStar.scale(0.05);
  
  bigBeat = new BeatDetector(this);
  bigBeat.input(in);
  // The sensitivity determines how long the detector will wait after detecting
  // a beat to detect the next one.
  beatDetector.sensitivity(50);
 bigBeat.sensitivity(0);
}


void draw() {
  //background(48, 25, 52);
  image(noisyBackground, 0, 0);
  translate(width * 0.8, height);
  float ampValue = amp.analyze();
  float newScale = map(ampValue, 0, 0.5, 0.5, 1);
  greenStar.scale(newScale);
  purpleStar.scale(newScale);

  for (int i = 1; i <=amountOfCircles; i++) {

    if (flip) {
      if (i % 2 == 0) {
        drawShapesInCircle(i, greenStar);
      } else {
        drawShapesInCircleOpposite(i, purpleStar);
      }
    } else {

      if (i % 2 == 0) {
        drawShapesInCircle(i, purpleStar);
      } else {
        drawShapesInCircleOpposite(i, greenStar);
      }
    }


    //for (float angle = originalAngle; angle < originalAngle + 360; angle+= 360/ (i*6)) {
    //  float x = cos(radians(angle)) * (radius * (0.6 * i));

    //  float y = sin(radians(angle)) * (radius * (0.6 * i));
    //  pushMatrix();
    //  translate(x, y);
    //  //rotate(angle / 60);
    //  shape(greenStar, 0, 0);
    //  popMatrix();
    //}
  }


  greenStar.scale(1/newScale);
  purpleStar.scale(1/newScale);
  if (ampValue > 0.3) {
    originalAngle+= map(ampValue, 0.3, 1, 1, 20);
    originalNegativeAngle -= map(ampValue, 0.3, 1, 1, 20);
    // println(ampValue);
  } else {
    originalAngle += 0.05;
    originalNegativeAngle -= 0.05;
  }
  
  detectFlip();
}


void detectFlip(){
  if(bigBeat.isBeat()){
   flip = !flip; 
  }
  
  
}

void drawShapesInCircle(int inputI, PShape sheep) {

  for (float angle = originalAngle; angle < originalAngle + 360; angle+= 360/ (inputI * 6)) {
    float x = cos(radians(angle)) * (radius * (0.6 * inputI));

    float y = sin(radians(angle)) * (radius * (0.6 * inputI));
    pushMatrix();
    translate(x, y);
    //rotate(angle / 60);
    shape(sheep, 0, 0);
    popMatrix();
  }
}

void drawShapesInCircleOpposite(int inputI, PShape sheep) {

  for (float angle = originalNegativeAngle; angle < originalAngle + 360; angle+= 360/ (inputI * 6)) {
    float x = cos(radians(angle)) * (radius * (0.6 * inputI));

    float y = sin(radians(angle)) * (radius * (0.6 * inputI));
    pushMatrix();
    translate(x, y);
    //rotate(angle / 60);
    shape(sheep, 0, 0);
    popMatrix();
  }
}
