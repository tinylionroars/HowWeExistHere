//Source code from Daniel Shiffman Learning Processing example 15-04
//Thomas Lengeling's example BodyTrack_Users
//Katherine Bennet & Hyacinth Nil offered counsel as well as any code attributed to them in comments
//All other code Phoenix Lio(n), based in examples on processing.org reference & Thomas Lengeling's KinectPV2 github

import KinectPV2.*; //References Thomas Leneling's KinectPV2 library

KinectPV2 kinect; //Creates a KinectPV2 object, stored in variable kinect


//int fuck = 0; //For testing a particularly annoying bug

int maxImages = 10; // Total # of recorded images

int maxScreen = 5; //Total # of displayed images

int maxFile = 500; //Total # of documented images


int imageIndex = 0; // Initial image to be recorded

int dispIndex = 0; //Initial image to be referenced

int screenIndex = 0; //Initial image to be displayed

int fileIndex = 0; //Initial image to be saved


PImage[] images = new PImage[maxImages]; //Declaring an array of images

PImage[] onScreen = new PImage[maxScreen]; //Declaring an array for images to view

//Line below written by Hyacinth Nil
String[] fileNames = new String[maxFile]; //Declaring an array for images to document

//int[] alphaScreen = new int[maxScreen]; //Declaring an array for the alpha of displayed images

void setup() { 
  size(1920, 1080); //Size matches the resolution of the kinect's color image 

  //Loading images into the array
  for (int i = 0; i < maxImages; i++) {
    images[i] = loadImage( "proto" + i + ".jpg" );
    image(images[i], random(-width/2, width/2), random(-height/2, height/2));
  }
  
  //Loop below written by Hyacinth Nil, based on recommendation by Katherine Bennett
  //Creating an array of strings which will name documentation images
  for(int f = 0; f < fileNames.length; f++){
    fileNames[f] = "output/doc" + f + ".jpg";
  }
  
  /*
  //Creating blank images to hold on screen data
  for (int s = 0; s < maxScreen; s++) {
    onScreen[s] = createImage(1920, 1080, ARGB);
    alphaScreen[s] = 0;
  }
  */
  
  kinect = new KinectPV2(this); //Loads kinect data into variable kinect

  kinect.enableBodyTrackImg(true); //Loads body track data from a kinect into sketch
  
  kinect.enableColorImg(true); //Loads color data from a kinect into sketch
  
  kinect.init(); //Initializes kinect
  
  //fullScreen(); //Runs sketch in fullscreen
}


void draw() {
  
  //Creates a conditional which runs every 3 seconds
  if ((second() % 3) == 0) {
    //Reloads images in array to put newly captured images in projection rotation
    for (int i = 0; i < maxImages; i++) {
      images[i] = loadImage( "proto" + i + ".jpg" );
    }
    //alphaScreen[screenIndex] = random(160,245); //Establishes initial alpha for images
    tint(random(60, 255), random(60, 255), random(60, 255), random(150,240)); //Randomizes rgb tint & alpha
    onScreen[screenIndex] = images[dispIndex]; //Places current display image inside
    image(images[dispIndex], random(-width/2, width/2), random(-height/2, height/2)); //Draws current display image to screen randomly
    delay(200); //Causes frame to run only 4 times during reference period
    dispIndex = (dispIndex + 1) % images.length; //Increment display image index by one each cycle % to return to 0 once the end of the array is reached
    screenIndex = (screenIndex + 1) % onScreen.length; //Increment screen image index by one each cycle % to return to 0 once the end of the array is reached
  }

  //I want to make the images decay (& ideally change tint as the alpha fades out)
  //NOT WORKING, try redrawing images every frame [make sure to redraw them in current order, reference screenIndex in new alphaIndew variable?
  //Make the color tint (& alpha?) run on a timer (delay()?) to avoid rapid flashing
  /*
  //creates
  for (int s = 0; s < maxScreen; s++) {
    if (alphaScreen[s] > 0) {
      alphaScreen[s] = alphaScreen[s] - int(random(50)); //Subtracts random number from current alpha if alpha is above 0
      onScreen[j].loadPixels();
      float r = random(60,255); //Creates variable for random red
      float g = random(60,255); //Creates variable for random green
      float b = random(60,255); //Creates variable for random blue
    }
    //Makes alpha flutter in & out after raching 0
    /*
    else {
      alphaScreen[s] = int(random(75)); //Sets alpha to random integer
    }
  }
  */
  
  
  //Establishes a conditional called when the kinect senses a body
  if (kinect.getNumOfUsers() > 0) {
    int imagesCount = second() % 10; //Reference timer for taking new projection images
    int fileCount = second() % 28; //Reference timer for taking new documentation images
    //Creates conditional which runs every reference time
    if ((imagesCount % 10) == 0){
      noTint(); //Resets ARGB data
      image(kinect.getColorImage(), 0, 0); //Displays image from kinect rgb camera feed
      saveFrame("data/proto" + imageIndex + ".jpg"); //Saves image to oldest reference image
      //Reloads images
      for (int i = 0; i < maxImages; i++) { 
        images[i] = loadImage( "proto" + i + ".jpg" );
      }
      image(images[imageIndex], 0, 0); //Prints image just captured
      imageIndex = (imageIndex + 1) % images.length; //Increment image index by one each cycle % to return to 0 once the end of the array is reached
      //imageIndex = int(random(images.length)); //A new image is picked randomly
      delay(1000); //Makes conditional run only once per reference second
    }
    //Creates conditional which runs every reference time
    if ((fileCount % 28) == 0){
      saveFrame(fileNames[fileIndex]); //Saves current frame to output file
      fileIndex++; //Increases fileIndex every time conditional is called
      /*
      println("fuck is " + fuck); //Prints if conditional is met
      fuck++; //Increases fuck every time conditional is called
      */
      delay(1000); //Makes conditional run only once per reference time
    }
  }
  
  //If the code gets too laggy over time or image is too distorted, add this to refresh the screen periodically
  /*
  //Establishes a conditional called when the kinect has not sensed a body for reference time
  if (kinect.getNumOfUsers() == 0 && minute() == 40){
    tint(random(60, 255), random(60, 255), random(60, 255), 255); //Randomizes rgb tint with full alpha
    //Prints all images in reference image array
    for (int i = 0; i < maxImages; i++) {
      image(images[i], random(-width/2, width/2), random(-height/2, height/2));
    }
    delay(2400000); //Makes conditional run only once per reference time
  }
  */
}