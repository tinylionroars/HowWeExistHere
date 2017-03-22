
long bodyStamp;
boolean bodySensed = false;
long interval = 4000;

void setup() {
  
}


void draw() {


  //if (bodySensed == true) {
    if(kinect2.getNumofUsers() > 0){
    bodyStamp = millis();
    if (millis() - bodyStamp > interval) {
      saveFrame(timestamp()+"_##.png");
    }
  } // if num users
  
  
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}