import ddf.minim.analysis.*;
import ddf.minim.*;
 
Minim minim;  
AudioPlayer mp3;
FFT fftLog;

PImage bg;
PImage bottommask;

PImage[] ca01 = new PImage[42]; 
PImage[] ca02 = new PImage[42]; 
PImage[] ca03 = new PImage[42]; 
PImage[] ca04 = new PImage[42]; 
PImage[] ca05 = new PImage[42]; 
PImage[] ca06 = new PImage[42]; 
PImage[] ca07 = new PImage[42]; 
PImage[] ca08 = new PImage[42]; 
PImage[] ca09 = new PImage[42]; 
PImage[] ca10 = new PImage[42]; 

void setup() {
  frameRate(25);
  size(1280, 600);
  frame.setBackground(new java.awt.Color(0, 0, 0));
  bg = loadImage("bg_720.png"); 
  bottommask = loadImage("mask_bottom_720.png"); 
  int c = 0;
  for (int i = 0; i < 164; i=i+4 ) {
    String formatted = String.format("%05d", i); 
    ca01[c] = loadImage( "720c/01_" + formatted + "-fs8.png" ); 
    ca02[c] = loadImage( "720c/02_" + formatted + "-fs8.png" ); 
    ca03[c] = loadImage( "720c/03_" + formatted + "-fs8.png" ); 
    ca04[c] = loadImage( "720c/04_" + formatted + "-fs8.png" ); 
    ca05[c] = loadImage( "720c/05_" + formatted + "-fs8.png" ); 
    ca06[c] = loadImage( "720c/06_" + formatted + "-fs8.png" ); 
    ca07[c] = loadImage( "720c/07_" + formatted + "-fs8.png" ); 
    ca08[c] = loadImage( "720c/08_" + formatted + "-fs8.png" ); 
    ca09[c] = loadImage( "720c/09_" + formatted + "-fs8.png" ); 
    ca10[c] = loadImage( "720c/10_" + formatted + "-fs8.png" ); 
    c++;
    println("loading: "+formatted);
  }
  
  minim = new Minim(this);
  mp3 = minim.loadFile("peer.mp3", 2048);
  mp3.loop();
  fftLog = new FFT(mp3.bufferSize(), mp3.sampleRate());
  fftLog.logAverages(22, 1);
  fftLog.window(FFT.HAMMING);
  
}

void draw() {
  fftLog.forward(mp3.mix);
  
  image(bg, 0, 0);
  
   image(ca01[getKeyForValue(int(fftLog.getAvg(0)), 75)], 0, 0);
   image(ca02[getKeyForValue(int(fftLog.getAvg(1)), 75)], 0, 0);
   image(ca03[getKeyForValue(int(fftLog.getAvg(2)), 75)], 0, 0);
   image(ca04[getKeyForValue(int(fftLog.getAvg(3)), 75)], 0, 0);
   image(ca05[getKeyForValue(int(fftLog.getAvg(4)), 75)], 0, 0);
   image(ca06[getKeyForValue(int(fftLog.getAvg(5)), 75)], 0, 0);
   image(ca07[getKeyForValue(int(fftLog.getAvg(6)), 60)], 0, 0);
   image(ca08[getKeyForValue(int(fftLog.getAvg(7)), 25)], 0, 0);
   image(ca09[getKeyForValue(int(fftLog.getAvg(8)), 25)], 0, 0);
   image(ca10[getKeyForValue(int(fftLog.getAvg(9)), 20)], 0, 0);

  image(bottommask, 0, 0);
} 


String getFileForValue( String candle, int val, int scale ){
 int max = 163; 
 float scaledval = (float)(((float)max/(float)scale))*val; 
 int scaledint = int(scaledval);
 if (scaledint > max){
   scaledint = max;
 }
 scaledint = max-scaledint;
 String formatted = String.format("%05d", scaledint); 
 return candle+"/"+candle+"_" + formatted + ".png";  
} 

int getKeyForValue( int val, int scale ){
 int max = 40; 
 float scaledval = (float)(((float)max/(float)scale))*(val); 
 int scaledint = int(scaledval);
 if (scaledint > max){
   scaledint = max;
 }
 scaledint = max-scaledint;
 return scaledint;
} 

void stop()
{
  mp3.close();
  minim.stop();
  super.stop();
}
