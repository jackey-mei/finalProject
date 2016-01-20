class Character {
  float xvelocity, xacceleration, yvelocity, yacceleration, xcor, ycor, gravity;
  boolean xleftSlowDown, xrightSlowDown, xstartUp, yslowDown, isFalling;
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
    isFalling = false;
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
       if (yvelocity >= 0) {
         yacceleration = 0;
         yslowDown = false;
       }
     }
     land();
     fall();
  }
  
  boolean standing(){
    return 1==getTile(xcor + 1,ycor+30).type || 
    1==getTile(xcor+19,ycor+30).type ||
    3==getTile(xcor + 1,ycor+30).type || 
    3==getTile(xcor+19,ycor+30).type;
  }
  
  int whatStand() {
    return getTile(xcor + 1, ycor + 30).type;
  }
  
  void land(){
   if(standing()){
     yvelocity = 0;
     yacceleration = 0;
     isFalling = false;
   }
  }
  
  void fall(){
    if(!standing() && !mainChar.yslowDown){
      mainChar.yvelocity = speedLimit/1.5;
      mainChar.yacceleration = 0.3;
      isFalling = true;
    }
  }
  
  boolean intoWallL(){
    return 0 != getTile(xcor-1,ycor + 1).type || //-1, 1
    0 != getTile(xcor-1,ycor+22).type; //-1, 22
  }
  
  boolean intoWallR(){
    return 0 != getTile(xcor+40,ycor + 1).type || //21, 1
    0 != getTile(xcor+40,ycor+22).type; //21, 22
  }
}
    