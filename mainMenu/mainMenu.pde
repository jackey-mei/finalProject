PFont font;
int fontsize = 20;
txtButton but1;
txtButton but2;
txtButton but3;

void setup() {
  size(640,480);
  colorMode(HSB);
  color buttonNormal = color(15,150,180);
  color buttonHover = color(10,200,200);
  background(190,80,40);
  noStroke();
  font = createFont("Arial",16,true);
  but1 = new txtButton(width/5,height/3+10*height/48,"Play",fontsize,buttonNormal,buttonHover);
  but2 = new txtButton(width/5,height/3+15*height/48,"Stage Select",fontsize,buttonNormal,buttonHover);
  but3 = new txtButton(width/5,height/3+20*height/48,"Exit",fontsize,buttonNormal,buttonHover);
}

void draw() {
  textAlign(LEFT,BOTTOM);
  fill(10,200,180);
  textFont(font,48);
  text("GO TO HELL",width/5,height/3);
  but1.draw();
  but2.draw();
  but3.draw();
  //text("Play1",width/5,height/3+10*height/48);
}
 void mousePressed(){
 if (but1.over == true){
  println("clicked play"); 
 }else if (but2.over == true){
  println("clicked stage select"); 
 }else if (but3.over == true){
  exit(); 
 }
}