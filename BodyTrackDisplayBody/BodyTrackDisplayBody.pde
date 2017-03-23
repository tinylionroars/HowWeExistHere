
//Source code & library by Thomas Lengeling


import KinectPV2.*;

import java.nio.*;


KinectPV2 kinect;

PGL pgl;


PShader sh;

int colorLoc;

int vertLoc;

float depthVal = 0;

int vertexVboId;

int colorVboId;

int zval = 350;

float scaleVal = 990;


boolean recording = false;

long bodyStamp;

long interval = 4000;


//PImage bodyTrack;

//PImage colorImg;


void setup() {
  
  size(1280, 720, P3D);
  
  
  kinect = new KinectPV2(this);

  kinect.enableBodyTrackImg(true);

  kinect.enableColorImg(true);

  kinect.enableDepthImg(true);
  
  kinect.enableColorPointCloud(true);

  kinect.init();
  
  
  sh = loadShader("frag.glsl", "vert.glsl");

  PGL pgl = beginPGL();
  
  IntBuffer intBuffer = IntBuffer.allocate(2);
  
  pgl.genBuffers(2, intBuffer);

  //memory location of the VBO
  vertexVboId = intBuffer.get(0);
  
  colorVboId = intBuffer.get(1);

  endPGL();
}

void draw() {

  //image(kinect.getBodyTrackImage(), 0, 0, 640, 480);
  
  image(kinect.getColorImage(), 0, 0, 320, 240);
  
  pushMatrix();
  
  translate(width / 2, height / 2, zval);
  
  scale(scaleVal, -1 * scaleVal, scaleVal);
  
  rotate(3, 0.0f, 1.0f, 0.0f);

  //render to the openGL object
  pgl = beginPGL();
  
  sh.bind();
  
  //obtain the body track positions
  FloatBuffer bodyTrackBuffer = kinect.getBodyTrackImage();

  //get the color for each point of the cloud Points
  FloatBuffer colorBuffer = kinect.getColorChannelBuffer();
  
  vertLoc = pgl.getAttribLocation(sh.glProgram, "vertex");
  
  pgl.enableVertexAttribArray(vertLoc);
  
  colorLoc = pgl.getAttribLocation(sh.glProgram, "color");
  
  pgl.enableVertexAttribArray(colorLoc);
  
  int vertData = kinect.WIDTHColor * kinect.HEIGHTColor * 3;
  
  //vertex
  {
    pgl.bindBuffer(PGL.ARRAY_BUFFER, vertexVboId);
    
    // fill VBO with data
    pgl.bufferData(PGL.ARRAY_BUFFER, Float.BYTES * vertData, bodyTrackBuffer, PGL.DYNAMIC_DRAW);
    
    // associate currently bound VBO with shader attribute
    pgl.vertexAttribPointer(vertLoc, 3, PGL.FLOAT, false, Float.BYTES * 3, 0);
  }
  
  // color
  {
    pgl.bindBuffer(PGL.ARRAY_BUFFER, colorVboId);
   
    // fill VBO with data
    pgl.bufferData(PGL.ARRAY_BUFFER, Float.BYTES * vertData, colorBuffer, PGL.DYNAMIC_DRAW);
    
    // associate currently bound VBO with shader attribute
    pgl.vertexAttribPointer(colorLoc, 3, PGL.FLOAT, false, Float.BYTES * 3, 0);
  }
  
  // unbind VBOs
  pgl.bindBuffer(PGL.ARRAY_BUFFER, 0);

  //draw the point cloud as a set of points
  pgl.drawArrays(PGL.POINTS, 0, vertData);

  //disable drawing
  pgl.disableVertexAttribArray(vertLoc);
  pgl.disableVertexAttribArray(colorLoc);

  //close the shader
  sh.unbind();
  //close the openGL object
  endPGL();
  
  popMatrix();

  stroke(255, 0, 0);
  text(frameRate, 50, height- 50);
  /*
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
  */
  
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
