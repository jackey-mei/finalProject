class Character {
  float xvelocity, xacceleration, yvelocity, yacceleration, xcor, ycor, gravity, speedlimit;
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
    speedlimit = 3.0;
    square = createShape(RECT, 0, 0, 10, 10);
    square.setFill(color(0, 100, 75));
    square.setStroke(false);
  }

  void draw() {
    //shape(square, xcor, ycor);
    //rect(xcor,ycor,10,15);
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
    land();
    fall();
    if (keyPressed) {
      if (!intoWallL()) {
        if (key == 'a') {
          println("a");
          if (yvelocity == 0 && yacceleration == 0) {
            if (xvelocity >= -speedlimit) {
              xacceleration = -0.2;
              xstartUp = true;
            } else if (xvelocity < -speedlimit) {
              if (xstartUp == true) {
                xacceleration = 0;
                xstartUp = false;
              }
            }
          }
          if (yvelocity != 0 || yacceleration != 0) {
            xacceleration = 0;
          }
        }
      }
      if (!intoWallR()) {
        if (key == 'd') {
          println("d");
          if (yvelocity == 0 && yacceleration == 0) {
            if (xvelocity <= speedlimit) {
              xacceleration = 0.2;
              xstartUp = true;
            } else if (xvelocity > speedlimit) {
              if (xstartUp == true) {
                xacceleration = 0;
                xstartUp = false;
              }
            }
          }
          if (yvelocity != 0 || yacceleration != 0) {
            xacceleration = 0;
          }
        }
      }
      if (key == ' ') {
        println("space");
        if (yvelocity == 0 && isFalling == false) {
          yvelocity = -speedlimit - 1;
          yacceleration = 0.2;
          yslowDown = true;
        }
        if (xvelocity >= speedlimit) {
          xvelocity = speedlimit;
          xacceleration = 0;
        } else if (xvelocity <= -speedlimit) {
          xvelocity = -speedlimit;
          xacceleration = 0;
        }
      }
    }
    if (intoWallL()) {
      println("Colliding WIth Left Wall");
      xvelocity = 0;
      xacceleration = 0;
      collided = true;
      xcor += 20;
    } else if (intoWallR()) {
      println("Colliding with Right Wall");
      xvelocity = 0;
      xacceleration = 0;
      collided = true;
      xcor -= 20;
    } else if (!intoWallL() && !intoWallR()) {
      collided = false;
    }
    //println(xvelocity);
    //println(intoWallL() +","+ intoWallR());
    //println(collided);
    //println(standing());
    //println(whatStand());
    //println(key);
  }

  //println(mainChar.xvelocity);

  boolean standing() {
    return 1==getTile(xcor + 1, ycor+30).type || 
      1==getTile(xcor+19, ycor+30).type ||
      3==getTile(xcor + 1, ycor+30).type || 
      3==getTile(xcor+19, ycor+30).type;
  }

  void land() {
    if (standing()) {
      yvelocity = 0;
      yacceleration = 0;
      isFalling = false;
    }
  }

  void fall() {
    if (!standing() && !yslowDown) {
      yvelocity = speedlimit/1.5;
      yacceleration = 0.3;
      isFalling = true;
    }
  }

  boolean intoWallL() {
    return 0 != getTile(xcor-1, ycor).type || //-1, 1
           0 != getTile(xcor-1, ycor+29).type; //-1, 22
  }

  boolean intoWallR() {
    return 0 != getTile(xcor+20, ycor).type || //21, 1
      0 != getTile(xcor+20, ycor+ 29).type; //21, 22
  }
}