import processing.video.*;

import org.multiply.processing.*;

Capture video

boolean recording = false;

void setup() {
  
  size(1280, 480);
  
  video = new Capture(this, 1280, 480);
  video.start();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  if (kinect.getNumOfUsers() > 0) {
    recording = true;
  }
  else () {
    recording = false;
  }
    if (recording) {
    saveFrame("output/frames####.png");
  }
}