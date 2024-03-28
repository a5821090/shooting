class Enemy extends DisplayObject{
int size_x,size_y;
color originalColor; // 元の色を保持するための変数
PImage img,img2;
int imageIndex;

Enemy(){
super();
syurui = 2; 
size_x= 100;
size_y= 100;
R = (int)random(10,256);
G =  (int)random(10,256);
B = (int)random(10,256);
originalColor=color(R,G,B);
col=color(R,G,B);
position.y=0;
position.x=(int)random(0,width);
move.x = random(-1,1);
move.y = random(0.1,1);
img = loadImage("enemy.png");
img2 = loadImage("enemy2.png");
imageIndex = (int) random(2);
  if (imageIndex == 0) {
    HP = (int) random(1, 5);
  } else {
    HP = (int) random(6, 10);
  }
}

void Draw(){
super.Draw();
colorMode(HSB);
fill((HP%10)*25,255,255);
PImage currentImg = (imageIndex == 0) ? img : img2;
image(currentImg, position.x, position.y, size_x, size_y);
position.add(move);
HPDisp();
  if(position.x < 0|| position.x > width-size_x ){
    position.x = constrain(position.x,0 , width - size_x); 
    move.x *= -1;
  }
colorMode(RGB);
}

//void setColor(int r, int g, int b) {//色を変えるメソッド
//col = color(r, g, b);
//}

// 元の色に戻すメソッド
//void resetColor() {
//col = originalColor;
//}

void HPDisp(){
  textSize(18);
  fill(255);
  text("HP:"+HP,position.x,position.y-10);
}
  
}
