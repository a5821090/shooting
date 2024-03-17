class Fighter extends DisplayObject{
int size;
int moveDirection;
  PImage img;

Fighter(){
super();
size = 100;
position.x = width / 2 - size / 2;
position.y = height - 80;
move.x = 15;
move.y = 0;
R = 255;
G = 255;
B = 255;
HP = 20;
syurui = 0;// 0＝Fighter
img = loadImage("fighter.png");
}

void Draw(){
super.Draw();
 HPDisp();  
image(img, position.x, position.y, size, 100);


}
void HPDisp(){
  textSize(18);
  fill(255);
  text("HP:"+HP,position.x,position.y+100);
}

}
