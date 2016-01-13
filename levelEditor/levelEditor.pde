//Press numbers 0-2 to change tile type
//Press z to toggle big brush mode

static int current,tileSize;
boolean bigBrush=false;
Tile[] board;
Tile hovered;

void setup(){
  size(640,480);
  board = new Tile[64*48];
  tileSize = 10;
  current=0;
  for (int row=0;row<48;row++){
    for(int col=0;col<64;col++){
      board[row*64+col]=new Tile(col,row,1,row*64+col);
    }
  }
}

void draw(){
  colorMode(HSB);
  noStroke();
  for(int i=0;i<board.length;i++){
    board[i].draw();
  }
  //Tile x = new Tile(10,10,0);
  //board[board.length-1].draw();
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

void keyPressed(){
  String msg ="";
  if(key=='z'){
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
  }
  println(msg);
}