class Character {
  float xvelocity, xacceleration, yvelocity, yacceleration, xcor, ycor, gravity;
  boolean xleftSlowDown, xrightSlowDown, xstartUp, yslowDown;
  PShape square;
  
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
    shape(square, xcor, ycor);
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
  } 
}
    