class Character {
  float xvelocity, xacceleration, yvelocity, yacceleration, xcor, ycor, gravity;
  boolean xleftSlowDown, xrightSlowDown, xstartUp, yslowDown;
  PShape square;
  PImage sprite = loadImage("charspriteR.png");
  
  Character(float xvelocity, float xacceleration, float yvelocity, float yacceleration, float xcor, float ycor) {
    this.xvelocity = xvelocity;
    this.xacceleration = xacceleration;
    this.yvelocity = yvelocity;
    this.yacceleration = yacceleration;
    this.xcor = xcor;
    this.ycor = ycor;
    xleftSlowDown = false;
    xrightSlowDown = false;
    xstartUp = false;
    square = createShape(RECT, 0, 0, 10, 10);
    square.setFill(color(0, 100, 75));
    square.setStroke(false);
  }
  
  void draw() {
    //shape(square, xcor, ycor);
    //rect(xcor,ycor,10,15);
    image(sprite,xcor,ycor);
    xvelocity += xacceleration;
    yvelocity += yacceleration;
    xcor += xvelocity;
    ycor += yvelocity;
    if (xrightSlowDown == true) {
       if (xvelocity <= 0) {
         xvelocity = 0;
         xacceleration = 0;
         xrightSlowDown = false;
       }
     }
     if (xleftSlowDown == true) {
       if (xvelocity >= 0) {
         xvelocity = 0;
         xacceleration = 0;
         xleftSlowDown = false;
       }
     }
     if (yslowDown == true) {
       if (yvelocity >= 1) {
         yacceleration = 0;
         yslowDown = false;
       }
     }
     land();
     //fall();
  }
  
  boolean standing(){
    return 1==getTile(xcor+1,ycor+31).type ||
    1==getTile(xcor+19,ycor+31).type ||
    2==getTile(xcor+1,ycor+31).type ||
    2==getTile(xcor+19,ycor+31).type;
  }
  
  void land(){
   if(standing()){
     yvelocity = 0;
     yacceleration = 0;
   }
  }
  
  void fall(){
    if(!standing()){
      mainChar.yvelocity = -3.0;
      mainChar.yacceleration = 0.2;
      mainChar.yslowDown = true;
    }
  }
}
    