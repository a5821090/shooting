class Health extends DisplayObject{
int size_x,size_y;
color originalColor; // 元の色を保持するための変数

Health(){
super();
syurui = 4; 
HP=(int)random(1,10);
position.y=0;
position.x=(int)random(0,width);
move.x = random(-1,1);
move.y = random(0.1,1);
}
void Draw(){
super.Draw();
noStroke();
fill(0,255,0);
rect(position.x,position.y,10, 30);
rect(position.x-10,position.y+10,30, 10);
 position.add(move);

 if(position.x-10 < 0|| position.x+20 > width ){
    position.x = constrain(position.x,0 , width); 
    move.x *= -1;
   }
}
void applyHealing(Fighter fighter) {
    // 自機のHPを回復
    fighter.HP += HP;
  }


  


}
