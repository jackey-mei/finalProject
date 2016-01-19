//Press numbers 0-4 to change tile type
//Press z to toggle big brush mode
//Press x to place saws

static int current,tileSize;
int stage = 2;
boolean bigBrush=false;
boolean sawmode=false;
boolean doormode1=false;
boolean doormode2=false;
Tile[] board;
Tile hovered;
ArrayList<Saw> sawlist = new ArrayList<Saw>();
ArrayList<Door> doorlist = new ArrayList<Door>(2);
PrintWriter out;
Saw ghostSaw;
Door ghostDoor;

void setup(){
  size(640,480);
  board = new Tile[64*48];
  tileSize = 10;
  current=0;
  for (int row=0;row<48;row++){
    for(int col=0;col<64;col++){
      board[row*64+col]=new Tile(col,row,1);
    }
  }
  out = createWriter("stage"+stage+".txt");
  ghostSaw = new Saw(mouseX,mouseY,10,10);
  ghostDoor = new Door(mouseX,mouseY,false);
}

void draw(){
  background(0);
  colorMode(HSB);
  noStroke();
  for(int i=0;i<board.length;i++){
    board[i].draw();
  }
  for(int i=0;i<sawlist.size();i++){
    sawlist.get(i).draw();
  }
  for(int i=0;i<doorlist.size();i++){
    doorlist.get(i).draw();
  }
  if(sawmode){
    ghostSaw.xcor = mouseX;
    ghostSaw.ycor = mouseY;
    ghostSaw.draw();
  }else if(doormode1 || doormode2){
    ghostDoor.xcor = mouseX;
    ghostDoor.ycor = mouseY;
    ghostDoor.draw();
  }
  //Saw x = new Saw(100,100,10,480);
  //x.draw();
}

void mouseDragged(){
  if(!bigBrush){
    hovered.type=current;
  }else{
    for(int y=-4;y<5;y++){
      for(int x=-4;x<5;x++){
        int n=(hovered.ycor+y)*64+hovered.xcor+x;
        if(n>0 && n<64*48){
          board[n].type=current;
        }
      }
    }
  }
}

void mousePressed(){
  if(sawmode){
    sawlist.add(new Saw(mouseX,mouseY,ghostSaw.damage,ghostSaw.rad));
  }else if(doormode1){
    doorlist.add(new Door(ghostDoor.xcor,ghostDoor.ycor,false));
  }else if(doormode2){
    doorlist.add(new Door(ghostDoor.xcor,ghostDoor.ycor,true));
  }else if(!bigBrush){
    hovered.type=current;
  }else{
    for(int y=-4;y<5;y++){
      for(int x=-4;x<5;x++){
        int n=(hovered.ycor+y)*64+hovered.xcor+x;
        if(n>0 && n<64*48){
          board[n].type=current;
        }
      }
    }
  }
}

void keyPressed(){
  String msg ="";
  if(sawmode){
   if(key=='-'){
     ghostSaw.shrink();
   }else if(key=='='){
     ghostSaw.grow();
   }
  }if(key=='z'){
    bigBrush=!bigBrush;
    println("Big brush "+bigBrush);
  }else if(key=='0'){
   current=0;
   msg="Air("+key+")";
  }else if(key=='1'){
    current=1;
    msg="Platform("+key+")";
  }else if(key=='2'){
    current=2;
    msg="Wall("+key+")";
  }else if(key=='3'){
    current=3;
    msg="Breakable("+key+")";
  }else if(key=='4'){
    current=4;
    msg="Damage("+key+")";
  }else if(key=='x'){
    sawmode=!sawmode;
    println("Place saws "+sawmode);
  }else if(key=='c'){
    doormode1=!doormode1;
    println("Place doors 1"+doormode1);
    ghostDoor.exit = false;
  }else if(key=='v'){
    doormode2=!doormode2;
    println("Place doors 2"+doormode2);
    ghostDoor.exit = true;
  }else if(key=='s'){
    for(int i=0;i<board.length;i++){
      out.println(board[i].xcor + "," + board[i].ycor + "," + board[i].type);
    }
    out.println("-doors-");
    for(int i=0;i<doorlist.size();i++){
      out.println(doorlist.get(i).xcor + "," + doorlist.get(i).ycor + "," + doorlist.get(i).exit);
    }
    out.println("-saws-");
    for(int i=0;i<sawlist.size();i++){
      out.println(sawlist.get(i).xcor + "," + sawlist.get(i).ycor + "," + sawlist.get(i).damage + "," + sawlist.get(i).rad);
    }
    out.flush();
    out.close();
    println("File saved");
  }
  println(msg);
}