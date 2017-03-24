// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com
// Example 15-04

import processing.video.*;

Capture video;

//boolean recording = false;

int maxImages = 10; // Total # of images

int imageIndex = 0; // Initial image to be displayed is the first

// Declaring an array of images.
PImage[] images = new PImage[maxImages];

int next = 0;

void setup() { 
  size(1000, 1000);
  
  // Loading the images into the array
  // Don't forget to put the JPG files in the data folder!
  for (int i = 0; i < images.length; i ++ ) {
    images[i] = loadImage( "proto" + i + ".jpg" );
  }
  
  video = new Capture(this, 640, 480);
  video.start();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  //image(video, 0, 0);

  if ((second() % 4) == 0) {
    int i = 0;
    image(images[i], random(1000), random(1000));
    i = (i + 1) % images.length;
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
