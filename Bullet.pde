class Bullet extends DisplayObject{
float radius;

Bullet(Fighter _fighter){
super();
syurui = 1; 
radius = 10;
R = 255;
G = 80;
B = 0;
move.x = 0;
move.y = -30;
HP = 1;
position.x = _fighter.position.x + _fighter.size/2; 
position.y = _fighter.position.y - radius; 
}

Bullet(Fighter _fighter, Enemy _enemy){
super();
syurui = 3; 
radius = 10;
R = 80;
G = 0;
B = 255;
HP = 1;
position.x = _enemy.position.x + _enemy.size_x/2; 
position.y = _enemy.position.y +_enemy.size_y+ radius;
move=_fighter.position.copy();
move = move.sub(_enemy.position);
move.normalize();
move.mult(5);  
}

void Draw(){
super.Draw();
fill( R,G,B);
ellipse(position.x, position.y, radius, radius);
position.add(move);
}

}
