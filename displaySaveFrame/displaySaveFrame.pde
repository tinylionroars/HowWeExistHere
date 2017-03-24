//Source code from Daniel Shiffman Learning Processing example 15-04
//All other code Phoenix Lio(n), based in examples on processing.org reference & libraries pages

import processing.video.*; //video library


Capture video;


//boolean recording = false; //toggle to saveFrame


int maxImages = 10; // Total # of recorded images

int maxScreen = 20; //Total # of displayed images


int imageIndex = 0; // Initial image to be recorded

int dispIndex = 0; //Initial image to be referenced

int screenIndex = 0; //Initial image to be displayed


PImage[] images = new PImage[maxImages]; //Declaring an array of images

PImage[] onScreen = new PImage[maxScreen]; //Declaring an array for images to view

int[] alphaScreen = new int[maxScreen]; //Declaring an array for each images alpha

void setup() { 
  size(640, 480);
  
  // Loading images into the array
  for (int i = 0; i < maxImages; i++) {
    images[i] = loadImage( "proto" + i + ".jpg" );
    image(images[i], random(-400, 400), random(-250, 250));
  }
  
  //Creating blank images to hold on screen data
  for (int j = 0; j < maxScreen; j++) {
    onScreen[j] = createImage(640, 480, ARGB);
    alphaScreen[j] = 0;
  }
    
  
  video = new Capture(this, 640, 480);
  video.start();
}


void captureEvent(Capture video) {
  video.read();
}


void draw() {
  //image(video, 0, 0);
  
  if ((second() % 5) == 0) {
    for (int i = 0; i < maxImages; i++) {
      images[i] = loadImage( "proto" + i + ".jpg" );
    }
    alphaScreen[screenIndex] = 255;
    tint(random(60, 255), random(60, 255), random(60, 255), alphaScreen[screenIndex]);
    onScreen[screenIndex] = images[dispIndex];
    image(onScreen[screenIndex], random(-400, 400), random(-250, 250);
    delay(200);
    dispIndex = (dispIndex + 1) % images.length;
    screenIndex = (screenIndex + 1) % onScreen.length;
  }
  
  loadPixels();
  
  for (int j = 0; j < maxScreen; j++) {
    if (alphaScreen[j] > 0) {
      alphaScreen[j] = alphascreen[j] - random(50);
      
    }
  }
      
      
  
  // increment image index by one each cycle
  // use modulo " % "to return to 0 once the end of the array is reached
  //imageIndex = (imageIndex + 1) % images.length;
  
  /*
  //recording save frame
  if (kinect.getNumOfUsers() > 0) {
    recording = true;
  }
  else () {
    recording = false;
  }
    if (recording) {
    saveFrame("output/frames####.png");
  }
  */
} 


void mousePressed() {
  tint(255,random(150,200));
  image(video, 0, 0);
  saveFrame("data/proto" + imageIndex + ".jpg");
  noTint();
  image(images[imageIndex], 0, 0);
  imageIndex = (imageIndex + 1) % images.length;
  // A new image is picked randomly when the mouse is clicked
  // Note the index to the array must be an integer!
  //imageIndex = int(random(images.length));
}
