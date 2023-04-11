import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 64;
float[] spectrum = new float[bands];
float[] sum = new float[3];

//green
color strpGreen = color(174, 195, 54);
//purple
color strpPurple = color(110, 81, 148);
//orange 216, 125, 18
color strpOrange  = color(216, 125, 18);
//red 211, 49, 12
color strpRed = color(211, 49, 12);

float outerCircleRadius = 1000;
float inbetweenCircleRadius = 700;
float innerCircleRadius = 300;
//purple 
float radiusIncrement = 20;

Amplitude amp;
void setup() {
  fullScreen();
  
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  amp = new Amplitude(this);
  amp.input(in);
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
  background(0);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  ellipseMode(RADIUS);
  frameRate(24);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  
  //drawGradient(0, 0, 1,300, strpGreen, strpPurple);
  getGradients();
}

void drawGradient(float x, float y, float startRadius, float endRadius, color from, color to) {
  
  float lerpSteps = 1/ ((endRadius - startRadius) / radiusIncrement);
  float lerpAmount = 1;
  for(float r = endRadius; r >= startRadius; r -= radiusIncrement){
    color tempColor = lerpColor(from, to, lerpAmount);
    fill(tempColor);
    ellipse(x, y, r, r);
    lerpAmount -= lerpSteps;
  }
  
}


void getGradients(){
  
  for(int i = 0; i < sum.length; i++){ //empty all the old sums out every iteration
    sum[i] = 0;
  }
  
  float ampValue =amp.analyze();
  
  
  //outer circle
  
  drawGradient(0, 0, 700, 1500, strpOrange, strpRed);
  //inbetween circle
  float endRadiusInbetweenCircle = map(ampValue, 0, 0.3, 400, 800);
  println(ampValue);
  drawGradient(0, 0, 400, endRadiusInbetweenCircle, strpRed, strpOrange);
  //inner 
  //float inbetweenSpectrumMean = getSpectrumMean(0, 21, 0); // inbetween circle
  //float innerSpectrumMean = getSpectrumMean(22,43, 1); //inner circle
  //float outerSpectrumMean = getSpectrumMean(44, 63, 2); //outer circle
  
  
  ////draw outer circle
  //float outerCircleBeginRadius = map(outerSpectrumMean, 0, 0.01, 700, 500);
  //drawGradient(0, 0, outerCircleBeginRadius, outerCircleRadius, strpOrange, strpRed);
  
  ////draw inbetween circle
  //float inbetweenCircleBeginRadius = map(inbetweenSpectrumMean, 0, 0.01, 400, 200);
  //drawGradient(0, 0, inbetweenCircleBeginRadius, inbetweenCircleRadius, strpRed, strpPurple);
  ////draw inner circle
  //float innerCircleEndnRadius = map(innerSpectrumMean, 0, 0.01, 400, 600);
  //drawGradient(0, 0, 0, innerCircleEndnRadius, strpGreen, strpPurple);
  
  
}

//float getSpectrumMean(int start, int stop, int whichArea){
//  //fft.analyze(spectrum);
//  //for(int i = start; i< stop; i++){
//  //  sum[whichArea] += spectrum[i];
//  //  println(sum[whichArea]);
//  //}
  
//  //return sum[whichArea]/ (stop - start);
  
//}
