class Door{
 boolean exit;
 int xcor,ycor;
 
 Door(int x,int y,boolean ex){
   xcor = x;
   ycor = y;
   exit = ex;
 }
 
 void draw(){
   if(exit){
     fill(21,51,220);
   }else{
     fill(21,20,150);
   }
   rect(xcor,ycor,30,40);
 }
 
 boolean insideDoor(int x,int y){
   return (x>=xcor && x<=xcor+30 && y>=ycor && y<=xcor+40) ||
   (x+20>=xcor && x+20<=xcor+30 && y+30>=ycor && y+30<=xcor+40);
 }
}