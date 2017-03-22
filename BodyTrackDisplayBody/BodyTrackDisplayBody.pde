//Source code & library by Thomas Lengeling


import KinectPV2.*;

import gab.opencv.*;


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

  
  
  PImage bodyTrack = kinect.getBodyTrackImage();
  
  opencv = new OpenCV(this, bodyTrack);
  
  opencv.useColor();
}

void draw() {

  image(kinect.getBodyTrackImage(), 0, 0, 640, 480);
  
  image(kinect.getColorImage(), 640, 0, 1280, 480);
  
  PImage bodyTrack = kinect.getBodyTrackImage();
  PImage colorImg = kinect.getColorImage();
  PImage layered = createImage(640, 480, RGB);
  
  layered.resize(640, 480);
  
  bodyTrack.loadPixels();
  colorImg.loadPixels();
  layered.loadPixels();
  
  layered = bodyTrack.get();
  
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      int loc = x + y * width;
      layered.pixels[loc] = color(colorImg.pixels[loc]);
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
