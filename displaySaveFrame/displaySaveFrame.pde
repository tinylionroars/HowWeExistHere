//Source code from Daniel Shiffman Learning Processing chapter 15-04
//All other code my own, based on examples on processing.org reference & library pages

import processing.video.*;

Capture video;

//boolean recording = false;

int maxImages = 10; // Total # of images

int imageIndex = 0; // Initial image to be recorded is the first

int dispIndex = 0; //Initial image to be displayed

// Declaring an array of images.
PImage[] images = new PImage[maxImages];

int next = 0;


int r = 255;

int g = 255;

int b = 255;

int a = 255;


void setup() { 
  size(640, 480);
  
  // Loading the images into the array
  // Don't forget to put the JPG files in the data folder!
  for (int i = 0; i < images.length; i ++ ) {
    images[i] = loadImage( "proto" + i + ".jpg" );
    image(images[i], random(-400, 400), random(-250, 250));
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
    tint(random(255), random(255), random(255), (frameCount - dispIndex*25) % 255);
    image(images[dispIndex], random(-400, 400), random(-250, 250));
    dispIndex = (dispIndex + 1) % images.length;
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
  image(video, 0, 0);
  saveFrame("data/proto" + imageIndex + ".jpg");
  imageIndex = (imageIndex + 1) % images.length;
  // A new image is picked randomly when the mouse is clicked
  // Note the index to the array must be an integer!
  //imageIndex = int(random(images.length));
}
