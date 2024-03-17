class DisplayObject {
PVector position;
 PVector move;
int R, G, B;
int syurui;
int HP;
color col;


DisplayObject(){ 
position = new PVector(0,0);
move = new PVector(0,0);
}
void Draw(){
  position.x += move.x *  fighter.moveDirection;
  if(position.x < 0 ){
  position.x=0;
 }else if(position.x > width-20){
   position.x=width-20;
 }
}


 
}
