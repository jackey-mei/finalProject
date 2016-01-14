int state; //0=Main Menu; 1=Play/Stage Select; 2=Stat Record; 3=Character Select
PFont font;
int fontsize = 20;
txtButton[] butts0 = new txtButton[3];
txtButton[] butts1 = new txtButton[11];

void setup() {
  size(640,480);
  //size(1280,960);
  colorMode(HSB);
  state = 0;
  color buttonNormal = color(15,150,180);
  color buttonHover = color(10,200,200);
  background(190,80,40);
  noStroke();
  font = createFont("Arial",16,true);
  butts0[0] = new txtButton(width/5,height/3+10*height/48,"Play",fontsize,buttonNormal,buttonHover);
  butts0[1] = new txtButton(width/5,height/3+15*height/48,"Records",fontsize,buttonNormal,buttonHover);
  butts0[2] = new txtButton(width/5,height/3+20*height/48,"Exit",fontsize,buttonNormal,buttonHover);
  butts1[0] = new txtButton(width/10,height-height/10,"Back",fontsize,buttonNormal,buttonHover);
  for(int i=1;i<butts1.length;i++){
    if(i<10&&i!=5){
      //butts1[i] = new txtButton((i/6)*i*width/6,(i/6)*height/4,"0"+i,fontsize,buttonNormal,buttonHover);
      butts1[i] = new txtButton(i%5*width/6,((i/6)+1)*height*4/11,"0"+i,fontsize,buttonNormal,buttonHover);
    }else if(i==5){
      butts1[i] = new txtButton(5*width/6,((i/6)+1)*height*4/11,"0"+i,fontsize,buttonNormal,buttonHover);
    }else{
     butts1[i] = new txtButton(5*width/6,((i/6)+1)*height*4/11,""+i,fontsize,buttonNormal,buttonHover); 
    }
  }
}

void draw() {
  textAlign(LEFT,BOTTOM);
  if(state==0){
    background(190,80,40);
    fill(10,200,180);
    textFont(font,48);
    text("GO TO HELL",width/5,height/3);
    butts0[0].draw();
    butts0[1].draw();
    butts0[2].draw();
  }else if(state==1){
    background(190,80,40);
    fill(10,200,180);
    textFont(font,36);
    textAlign(CENTER,BOTTOM);
    text("Stage Select",width/2,height/5);
    for(int i=0;i<butts1.length;i++){
      butts1[i].draw();
    }
    fill(255);
    line(width/10,height-height/10,0,0);
  }
}
 void mousePressed(){
   if(state==0){
     if (butts0[0].over == true){
       state=1;
       println("clicked play"); 
     }else if (butts0[1].over == true){
       state=2;
       println("clicked Records"); 
     }else if (butts0[2].over == true){
       exit(); 
     }
   }else if(state==1){
     if (butts1[0].over == true){
       state=0; 
       println("Back");
     }
   }
 }