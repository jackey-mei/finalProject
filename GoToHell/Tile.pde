class Tile {
 int xcor, ycor;
 int type; // 0 = air; 1 = platform; 2 = wall; 3 = breakable; 4 = damage;
 boolean over;
 color col;

 Tile(int x, int y, int type) {
   xcor = x;
   ycor = y;
   this.type = type;
 }
 
 void draw() {
     if (type == 0) {
       col = color(150, 60, 120);
     }
     else if (type == 1) {
       col = color(340, 20, 20);
     }
     else if (type == 2) {
       col = color(340, 20, 50);
     }
     else if (type == 3) {
       col = color(25, 120, 85);
     }
     else if (type == 4) {
       col = color(5, 180, 85);
     }
   fill(col);
   noStroke();
   rect(xcor * tileSize, ycor * tileSize, tileSize, tileSize);
   //stroke(0, 255, 200);
   //point((xcor + 1) * tileSize, (ycor + 1) * tileSize);
 }
 
 String toString() {
  return "(" + xcor + "," + ycor+ ")" + " " + type; 
 }
 
}
 