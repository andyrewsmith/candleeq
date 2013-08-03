import ddf.minim.analysis.*;
import ddf.minim.*;
 
Minim minim;  
AudioPlayer mp3;
FFT fftLog;

PImage bg;
PImage bottommask;

PImage[] ca01 = new PImage[21]; 
PImage[] ca02 = new PImage[21]; 
PImage[] ca03 = new PImage[21]; 
PImage[] ca04 = new PImage[21]; 
PImage[] ca05 = new PImage[21]; 
PImage[] ca06 = new PImage[21]; 
PImage[] ca07 = new PImage[21]; 
PImage[] ca08 = new PImage[21]; 
PImage[] ca09 = new PImage[21]; 
PImage[] ca10 = new PImage[21]; 

void setup() {
  frameRate(25);
  size(1280, 600);
  frame.setBackground(new java.awt.Color(0, 0, 0));
  bg = loadImage("bg_720.png"); 
  bottommask = loadImage("mask_bottom_720.png"); 
  int c = 0;
  for (int i = 0; i < 164; i=i+8 ) {
    String formatted = String.format("%05d", i); 
    ca01[c] = loadImage( "720/01_" + formatted + ".png" ); 
    ca02[c] = loadImage( "720/02_" + formatted + ".png" ); 
    ca03[c] = loadImage( "720/03_" + formatted + ".png" ); 
    ca04[c] = loadImage( "720/04_" + formatted + ".png" ); 
    ca05[c] = loadImage( "720/05_" + formatted + ".png" ); 
    ca06[c] = loadImage( "720/06_" + formatted + ".png" ); 
    ca07[c] = loadImage( "720/07_" + formatted + ".png" ); 
    ca08[c] = loadImage( "720/08_" + formatted + ".png" ); 
    ca09[c] = loadImage( "720/09_" + formatted + ".png" ); 
    ca10[c] = loadImage( "720/10_" + formatted + ".png" ); 
    c++;
    println("loading: "+formatted);
  }
  
  minim = new Minim(this);
  mp3 = minim.loadFile("re.mp3", 2048);
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
   image(ca07[getKeyForValue(int(fftLog.getAvg(6)), 75)], 0, 0);
   image(ca08[getKeyForValue(int(fftLog.getAvg(7)), 75)], 0, 0);
   image(ca09[getKeyForValue(int(fftLog.getAvg(8)), 75)], 0, 0);
   image(ca10[getKeyForValue(int(fftLog.getAvg(9)), 75)], 0, 0);

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
 int max = 20; 
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
