class Character {
  float xvelocity, xacceleration, yvelocity, yacceleration, xcor, ycor, gravity, speedlimit;
  boolean xleftSlowDown, xrightSlowDown, xstartUp, yslowDown, isFalling, hasJumped, movingLeft, movingRight, keyPriorityLeft, keyPriorityRight;
  //PShape square;
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
    hasJumped = false;
    speedlimit = 3.0;
    movingLeft = false;
    movingRight = false;
    keyPriorityLeft = false;
    keyPriorityRight = false;
    //square = createShape(RECT, 0, 0, 10, 10);
    //square.setFill(color(0, 100, 75));
    //square.setStroke(false);
  }

  void draw() {
    //shape(square, xcor, ycor);
    //rect(xcor, ycor, 10, 15);
    image(sprite, xcor, ycor);
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
        yslowDown = false;
      }
    }
    if (keyPressed) {
      if (!intoWallL()) {
        if (key == 'a') {
          movingLeft = true;
          keyPriorityLeft = true;
          keyPriorityRight = false;
        }
      }
      if (!intoWallR()) {
        if (key == 'd') {
          movingRight = true;
          keyPriorityLeft = false;
          keyPriorityRight = true;
        }
      }
      if (!intoCeiling())
        if (key == ' ') {
          if (!hasJumped) {
            if (yvelocity == 0 && isFalling == false) {
              yvelocity = -speedlimit - 1;
              yacceleration = 0.15;
              yslowDown = true;
              isFalling = true;
            }
          }
          hasJumped = true;
        }
      }
      if (movingLeft && keyPriorityLeft) {
        if (yvelocity == 0 && yacceleration == 0) {
          if (xvelocity >= -speedlimit) {
            xacceleration = -0.2;
            xstartUp = true;
          } 
          else if (xvelocity < -speedlimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        } 
        else {
          if (xvelocity >= -speedlimit) {
            xacceleration = -0.15;
            xstartUp = true;
          } 
          else if (xvelocity < -speedlimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
      }
      if (movingRight && keyPriorityRight) {
        if (yvelocity == 0 && yacceleration == 0) {
          if (xvelocity <= speedlimit) {
            xacceleration = 0.2;
            xstartUp = true;
          } 
          else if (xvelocity > speedlimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
        else {
          if (xvelocity <= speedlimit) {
            xacceleration = 0.15;
            xstartUp = true;
          } 
          else if (xvelocity > speedlimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
      }
      println(yvelocity);
      if (intoWallL()) {
        println("Colliding With Left Wall");
        xvelocity = 0;
        xacceleration = 0;
        xcor += 1;
      } 
      else if (intoWallR()) {
        println("Colliding With Right Wall");
        xvelocity = 0;
        xacceleration = 0;
        xcor -= 1;
      } 
      if (intoCeiling()) {
        println("Colliding With Ceiling");
        ycor += 1;
      }
      if (intoFloor()) {
        println("Colliding With Floor");
        if (yvelocity > 0) {
          yvelocity = 0;
          yacceleration = 0;
          isFalling = false;
        }
      }
      else {
        yacceleration = 0.15;
        isFalling = true;
      }
  }

  boolean intoFloor() {
    return 1 == getTile(xcor + 5, ycor + 30).type || 
    1 == getTile(xcor + 15, ycor + 30).type ||
    3 == getTile(xcor + 5, ycor + 30).type || 
    3 == getTile(xcor + 15, ycor + 30).type;
  }

  boolean intoWallL() {
    return 0 != getTile(xcor - 1, ycor + 5).type || //-1, 1
    0 != getTile(xcor - 1, ycor + 25).type; //-1, 22
  }
  
  boolean intoWallR() {
    return 0 != getTile(xcor + 20, ycor + 5).type || //21, 1
    0 != getTile(xcor + 20, ycor + 25).type; //21, 22
  }
  
  boolean intoCeiling() {
    return 0 != getTile(xcor + 5, ycor - 5).type ||
    0 != getTile(xcor + 15, ycor - 5).type;
  }
}