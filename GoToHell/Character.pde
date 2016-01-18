class Character {
  float xvelocity, xacceleration, yvelocity, yacceleration, xcor, ycor;
  boolean xleftSlowDown, xrightSlowDown, xstartUp;
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
    if (mainChar.xrightSlowDown == true) {
       if (mainChar.xvelocity <= 0) {
         mainChar.xvelocity = 0;
         mainChar.xacceleration = 0;
         mainChar.xrightSlowDown = false;
       }
     }
     if (mainChar.xleftSlowDown == true) {
       if (mainChar.xvelocity >= 0) {
         mainChar.xvelocity = 0;
         mainChar.xacceleration = 0;
         mainChar.xleftSlowDown = false;
       }
     }
  } 
}
    