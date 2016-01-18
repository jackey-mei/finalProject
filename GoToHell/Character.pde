class Character {
  float xvelocity, xacceleration, yvelocity, yacceleration;
  int xcor, ycor;
  boolean xslowDown, xstartUp;
  PShape square;
  
  Character(float xvelocity, float xacceleration, float yvelocity, float yacceleration, int xcor, int ycor) {
    this.xvelocity = xvelocity;
    this.xacceleration = xacceleration;
    this.yvelocity = yvelocity;
    this.yacceleration = yacceleration;
    this.xcor = xcor;
    this.ycor = ycor;
    xslowDown = false;
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
    if (xvelocity >= 1.5) {
      xacceleration = 0;
    }
    if (xslowDown == true) {
      if (xvelocity < 0.1) {
        xvelocity = 0;
        xacceleration = 0;
        xslowDown = false;
      }
    }
    if (xstartUp == true) {
      if (xvelocity >= 1.5) {
      xacceleration = 0.1;
  } 
}
    