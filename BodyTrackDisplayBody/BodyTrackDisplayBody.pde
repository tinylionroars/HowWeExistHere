//Source code & library by Thomas Lengeling


import KinectPV2.*;

import gab.opencv.*;

import processing.video.*;


Capture video;

KinectPV2 kinect;

OpenCV opencv;


boolean recording = false;

long bodyStamp;

long interval = 4000;


PImage bodyTrack;

PImage colorImg;


void setup() {
  
  size(1280, 480);
  
  
  kinect = new KinectPV2(this);

  kinect.enableBodyTrackImg(true);

  kinect.enableColorImg(true);
  
  kinect.enableDepthImg(true);

  kinect.init();
  
  
  video = new Capture(this, 640, 480);
  video.start();
  
  
  PImage bodyTrack = kinect.getBodyTrackImage();
  
  opencv = new OpenCV(this, bodyTrack);
  
  opencv.useColor();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {

  image(kinect.getBodyTrackImage(), 0, 0, 640, 480);
  
  image(video, 640, 0, 1280, 480);
  
  
  PImage bodyTrack = kinect.getBodyTrackImage();
  PImage colorImg = kinect.getColorImage();
  
  bodyTrack.loadPixels();
  colorImg.loadPixels();
  
  createImage(bodyTrack,
  
  for(float x = 0; x < width; x++) {
    for(float y = 0; y < height; y++) {
      float loc = x + y * width;
      bodyTrack.pixels[loc] = color(colorImg.pixels[loc]);
    }
  }
 
 
  //obtain an ArrayList of the users currently being tracked
  //ArrayList<PImage> bodyTrackList = kinect.getBodyTrackUser();

/*
  //iterate through all the users
  for (int i = 0; i < bodyTrackList.size(); i++) {
    PImage bodyTrackImg = (PImage)bodyTrackList.get(i);
    if (i <= 2)
      image(bodyTrackImg, 320 + 240*i, 0, 320, 240);
    else
      image(bodyTrackImg, 320 + 240*(i - 3), 424, 320, 240 );
  }

/*
  fill(0);
  textSize(16);
  text(kinect.getNumOfUsers(), 50, 50);
  text(bodyTrackList.size(), 50, 70);
  
    if (kinect.getNumOfUsers() > 0) {
    recording = true;
  }
  else {
    recording = false;
  }
    if (recording) {
    saveFrame("output/frames####.png");
  }
*/
/*
  if (kinect.getNumOfUsers() > 0) {
        bodyStamp = millis();
    if (millis() - bodyStamp > interval) {
      saveFrame(timestamp()+"_##.png");
    }
  }
}

String timestamp() {
  int d = day();
  int m = month();
  int y = year();
  int h = hour();
  int s = second();
  return String.format(y + "_" + m + "_" + d + "_" + h + "_" + s);
*/
}
