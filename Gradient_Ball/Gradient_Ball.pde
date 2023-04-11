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

float divider = 100;
float noiseDivider = random(10);
float noiseSpeed = random(10);
BeatDetector beatDetector;
BeatDetector bigBeat;

int r = 0;
color pinkpopPink = color(255,62, 150);
color pinkpopGreen = color(155, 209, 158);
color white = color(255, 255, 255);

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


void setup(){
  
  
}


void draw(){
  
  
  
}
