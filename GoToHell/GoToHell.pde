static int state, tileSize; //  0 = Main Menu; 1 = Play / Stage Select; 2 = Stat Record; 3 = Pause;
                            // 11 - 20 = stages 1 - 10
PFont font;
int fontsize = 20, beforePause;
txtButton[] butts0 = new txtButton[3];
txtButton[] butts1 = new txtButton[11];
Tile[] board;
BufferedReader reader;
Character mainChar;
char currentKey;
color buttonNormal, buttonHover;
PImage mainmenu, stagebg;
Saw[] sawlist;
Door[] doorlist = new Door[2];
Timer timer;

void setup() {
  size(640, 480);
  //size(1280, 960);
  tileSize = width / 64;
  colorMode(HSB);
  state = 0;
  buttonNormal = color(240, 127, 190);
  buttonHover = color(248, 163, 230);
  background(190, 80, 40);
  noStroke();
  mainmenu = loadImage("mainmenu.png");
  font = createFont("Arial-Black", 16, true);
  butts0[0] = new txtButton(width / 5, height / 3 + 10 * height / 48, "Play", fontsize, buttonNormal, buttonHover);
  butts0[1] = new txtButton(width / 5, height / 3 + 15 * height / 48, "Records", fontsize, buttonNormal, buttonHover);
  butts0[2] = new txtButton(width / 5, height / 3 + 20 * height / 48, "Exit", fontsize, buttonNormal, buttonHover);
  butts1[0] = new txtButton(width / 10, height - height / 10, "Back", fontsize, buttonNormal, buttonHover);
  for (int i = 1; i < butts1.length; i ++) {
    if (i < 10 && i != 5) {
      // butts1[i] = new txtButton((i / 6) * i * width / 6, (i / 6) * height / 4, "0" + i, fontsize, buttonNormal, buttonHover);
      butts1[i] = new txtButton(i % 5 * width / 6, ((i / 6) + 1) * height * 4 / 11, "0" + i, fontsize, buttonNormal, buttonHover);
    } 
    else if (i == 5) {
      butts1[i] = new txtButton(5 * width / 6, ((i / 6) + 1) * height * 4 / 11, "0" + i, fontsize, buttonNormal, buttonHover);
    } 
    else {
      butts1[i] = new txtButton(5 * width / 6, ((i / 6) + 1) * height * 4 / 11, "" + i, fontsize, buttonNormal, buttonHover);
    }
  }
  board = new Tile[64 * 48];
  timer = new Timer();
}

void draw() {
  textAlign(LEFT, BOTTOM);
  if (state == 0) {
    background(mainmenu);
    fill(buttonHover);
    textFont(font, 48);
    text("GO TO HELL", width / 5, height / 3);
    butts0[0].draw();
    butts0[1].draw();
    butts0[2].draw();
  } 
  else if (state == 1) {
    background(190, 80, 40);
    fill(buttonHover);
    textFont(font, 36);
    textAlign(CENTER, BOTTOM);
    text("Stage Select", width / 2, height / 5);
    for (int i = 0; i < butts1.length; i ++) {
      butts1[i].draw();
    }
    fill(255);
    line(width / 10, height - height / 10, 0, 0);
  } 
  else if (state == 3) {
    fill(255);
    textSize(100);
    text("PAUSE", 120, 290);
  }
  else if (state > 10 && state < 21) {
    background(190, 80, 40);
    for (int x = 0; x < 10; x ++) {
      if (state == 11 + x) {
        timer.end();
        
        //println(timer.result());
        stagebg = loadImage("stagebg" + (x + 1) + ".png");
        background(stagebg);
        for (int i = 0; i < board.length; i ++) {
          board[i].draw();
        }
        for (int i = 0; i < doorlist.length; i ++) {
          doorlist[i].draw();
          if (i==1 && doorlist[i].insideDoor((int)mainChar.xcor, (int)mainChar.ycor)) {
            println("DOOR");
            setStage(state - 10 + 1);
          }
        }
        mainChar.draw();
        for (int i = 0; i < sawlist.length; i ++) {
          sawlist[i].draw();
          if (sawlist[i].insideSaw((int)mainChar.xcor, (int)mainChar.ycor)) {
            // println("HURT!!");
          }
        }
        textSize(15);
        fill(255);
        text("" + timer.result(), 25, 35);
      }
      //println(key);
      else if (state == 21) {
        state = 1;
      }
    }
  }
}

void keyReleased() {
  if (key == 'f') {
    mainChar.xacceleration = -0.2;
    mainChar.xrightSlowDown = true;
    mainChar.movingRight = false;
    mainChar.keyPriorityRight = false;
  }
  if (key == 's') {
    mainChar.xacceleration = 0.2;
    mainChar.xleftSlowDown = true;
    mainChar.movingLeft = false;
    mainChar.keyPriorityLeft = false;
  }
  if (key == ' ') {
    mainChar.hasJumped = false;
  }
  if (keyCode == SHIFT) {
    mainChar.sprint = false;
  }
}

void keyPressed() {
  if (key == 27 && state < 21 && state > 10) {
    key = 0;
    beforePause = state;
    state = 3;
  }
  else if (key == 27 && state == 3) {
    key = 0;
    state = beforePause;
  }
}
 
void mousePressed() {
  if (state == 0) {
    if (butts0[0].over == true) {
      state = 1;
      println("Clicked Play");
    } 
    else if (butts0[1].over == true) {
      state = 2;
      println("Clicked Records");
    } 
    else if (butts0[2].over == true) {
      exit();
    }
  }
  else if (state == 1) {
    if (butts1[0].over == true) {
      state = 0; 
      println("Back");
    } 
    else {
      for (int n = 1; n < butts1.length; n++) {
        if (butts1[n].over == true) {
          setStage(n);
        }
      }
    }
  }
}

// takes pixel coordinates and returns the Tile on those coordinates
Tile getTile(float x, float y) {
  int xcor = (int)x / 10;
  int ycor = (int)y / 10;
  return board[xcor + ycor * 64];
}

void setStage(int n) {
  state = 10 + n;
  if (state != 21) {
    println("Stage " + n);
    String[] lines = loadStrings("stage" + n + ".txt");
    String[] tileInfo;
    for (int i = 0; i < board.length; i ++) {
      tileInfo = lines[i].split(",");
      board[i] = new Tile(Integer.parseInt(tileInfo[0]), Integer.parseInt(tileInfo[1]), Integer.parseInt(tileInfo[2]));
    }
    String[] door = lines[board.length + 1].split(",");
    doorlist[0] = new Door(Integer.parseInt(door[0]), Integer.parseInt(door[1]), false);
    door = lines[board.length + 2].split(",");
    doorlist[1] = new Door(Integer.parseInt(door[0]), Integer.parseInt(door[1]), true);
    sawlist = new Saw[lines.length - (board.length + 4)];
    String[] saw;
    for (int i = 0; i < sawlist.length; i ++) {
      saw = lines[board.length + 4 + i].split(",");
      sawlist[i] = new Saw(Integer.parseInt(saw[0]), Integer.parseInt(saw[1]), Integer.parseInt(saw[2]), Integer.parseInt(saw[3]));
    }
    mainChar = new Character(0, 0, 0, 0, doorlist[0].xcor + 5, doorlist[0].ycor + 10);
    timer.begin();
  }
}