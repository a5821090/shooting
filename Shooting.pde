/*
・遊び方
スペースキーで銃弾を撃ち、マウスで自機を移動する
敵と敵の銃弾に当たるとダメージを受けるよ
時間が経つと敵の出現確率と銃弾の発射確率が上がるよ(確率はコンソールで確認できます)
たまに降ってくる回復アイテム(回復量はランダム)を取って勝利を目指そう！
Scoreが100以上でゲームクリア！
自機のHPが0になるとゲームオーバーだよ
クリア後、ゲームオーバー後はEnterキーで最初からスタートします。
音あり推奨！！！！！！！！！^^
@itohcompany
*/


import ddf.minim.*;
Minim minim;
AudioSample bullet_sound, damage_sound,explosion_sound,health_sound,end_sound,win_sound;
ArrayList<DisplayObject>objects = new ArrayList<DisplayObject>();
int Score=0;
boolean gameover = false;
int rate=3,brate=1;
ArrayList<Particle> particles = new ArrayList<Particle>();

Fighter fighter; 
Enemy enemy;
Health health;

void setup(){
size(800,800); 
fighter = new Fighter();
objects.add(fighter);
enemy=new Enemy();
objects.add(enemy);
minim = new Minim(this);
bullet_sound = minim.loadSample("Bullet.mp3");
explosion_sound = minim.loadSample("Explosion.mp3");
damage_sound = minim.loadSample("Damage.mp3");
health_sound=minim.loadSample("Health.mp3");
end_sound=minim.loadSample("end.mp3");
win_sound=minim.loadSample("win.mp3");
}

void draw(){
background(221,160,221);
  if(gameover == false){
    if(random(1000)<rate){
      objects.add(new Enemy());
    }
    if(frameCount%100==0){
    rate++;
    println("敵の出現確率:"+rate+"%");
    }
    if (frameCount % 500 == 0) { // 500フレームごとに回復アイテムを生成
    objects.add(new Health());
    }
    if(frameCount < 100){
    fill(255,255,255);
    textAlign(CENTER, CENTER);
    text("S T A R T", width/2, height/2);
    return;
    }
    textSize(24);
    fill(255);
    textAlign(RIGHT);
    text("SCORE:"+Score,width,24);
    textAlign(TOP,LEFT);
    
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      p.display();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  
    fighter.position.x=mouseX;
    fighter.position.y=mouseY;
  
  
    for(int i = 0; i < objects.size();i++){
      objects.get(i).Draw();
      if(objects.get(i).syurui ==2){
        if(random(100)<brate){
          Enemy enmy = (Enemy)objects.get(i);
          objects.add(new Bullet(fighter,enmy));
          if(frameCount%300==0){
            brate++;
            println("弾の発射確率:"+brate+"%");
          }
        }
      }
      if(objects.get(i).syurui ==1 && objects.get(i).position.y < 0){
        objects.remove(i); 
      }else if((objects.get(i).syurui ==2)&& (objects.get(i).position.y > height-enemy.size_y)){
        objects.remove(i); 
      }else if((objects.get(i).syurui ==3)&&  objects.get(i).position.y >height){
        objects.remove(i); 
      }
    }
  
    Collision();
    CollisionFighter();
    CollisionBullet();
    CollisionHealth();
  
  }else{
    textSize(50);
    fill(255);
    textAlign(CENTER,CENTER);
    if(Score>=100){
      text("Game Clear!",width/2,height/2);
    }else{
      text("Game Over",width/2,height/2);
    }
    textSize(30);
    fill(255);
    textAlign(CENTER,CENTER);
    text("Press Enter",width/2,height/2+50);
    return;
  }

}


void keyPressed(){
  if(key == ' '){
   objects.add(new Bullet(fighter));
   bullet_sound.trigger();
  }
  if(keyCode==LEFT){
   fighter.moveDirection-=1;
  }else if(keyCode==RIGHT){
   fighter. moveDirection+=1;   
  }
  if(key=='\n'){
   GameStart();
   gameover=false;
  }
}

void keyReleased(){
fighter.moveDirection=0;
}

void Collision(){
  for(int i=0;i<objects.size();i++){
    if(objects.get(i).syurui==1){
      for(int j=0;j<objects.size();j++){
         if(objects.get(j).syurui==2){
           Enemy enmy = (Enemy)objects.get(j);
           if(objects.get(i).position.x>objects.get(j).position.x
           &&objects.get(i).position.y>objects.get(j).position.y
           &&objects.get(i).position.x<objects.get(j).position.x+enmy.size_x
           &&objects.get(i).position.y<objects.get(j).position.y+enmy.size_y){
             objects.get(j).HP -= objects.get(i).HP;
             objects.get(i).HP--;
             Score++;
             if(Score>=100){
               win_sound.trigger();
               gameover=true;
             }
             if(objects.get(j).HP <= 0) {
               explosion_sound.trigger();
               createExplosion(objects.get(j).position.x,objects.get(j).position.y);
             }else{
               damage_sound.trigger();
             }
           }
         }
      }
    }
  }
  for(int i=0; i< objects.size();i++){
    if(objects.get(i).HP <= 0) {
      objects.remove(i);
    }
    if(objects.size() <= i) break;
  }  
}

void CollisionFighter(){
  for(int i=0;i<objects.size();i++){
    if(objects.get(i).syurui==0){
      for(int j=0;j<objects.size();j++){
         if(objects.get(j).syurui==2){
           Enemy enmy = (Enemy)objects.get(j);
           if(Math.abs(objects.get(i).position.x- objects.get(j).position.x) < 10 +enmy.size_x/2 
           &&Math.abs(objects.get(i).position.y- objects.get(j).position.y) < 20 +enmy.size_y/2){
             objects.get(i).HP -= objects.get(j).HP;
             objects.remove(j);
             if(objects.get(i).HP <= 0) {
                 createExplosion(objects.get(i).position.x,objects.get(i).position.y);
                 explosion_sound.trigger();
                 end_sound.trigger();
                 gameover=true;
             }else{
                 damage_sound.trigger();
             }
           }
         }
      }
    }
  }
  for(int i=0; i< objects.size();i++){
    if(objects.get(i).HP <= 0) {
      objects.remove(i);  
    }
    if(objects.size() <= i) break;
  }
}

void CollisionBullet(){
  for(int i=0;i<objects.size();i++){
    if(objects.get(i).syurui==0){
      for(int j=0;j<objects.size();j++){
         if(objects.get(j).syurui==3){
           if(objects.get(i).position.x<objects.get(j).position.x
           &&objects.get(i).position.y<objects.get(j).position.y
           &&objects.get(i).position.x+fighter.size>objects.get(j).position.x
           &&objects.get(i).position.y+40>objects.get(j).position.y){
             objects.get(i).HP -= objects.get(j).HP;
             objects.get(j).HP--;
             if(objects.get(i).HP <= 0) {
               createExplosion(objects.get(i).position.x,objects.get(i).position.y);
               explosion_sound.trigger();
               end_sound.trigger();
               gameover=true;
             }else{
               damage_sound.trigger();
             }
           }
         }
      }
    }
  }
  for(int i=0; i< objects.size();i++){
    if(objects.get(i).HP <= 0) {
      objects.remove(i);
    }
    if(objects.size() <= i) break;
  }
}

void CollisionHealth(){
  for (int i = 0; i <objects.size() ; i++) {
    if (objects.get(i).syurui == 4) { // 回復アイテムの syurui を確認
      float distance = dist(objects.get(i).position.x, objects.get(i).position.y, fighter.position.x, fighter.position.y);
      if (distance < fighter.size / 2) {
      health_sound.trigger();
      Health healthItem = (Health) objects.get(i);
      healthItem.applyHealing(fighter);
      objects.remove(i); // 回復アイテムを削除
      }
    }
  }
}

void GameStart(){
  objects = new ArrayList<DisplayObject>();
  Score=0; 
  fighter = new Fighter();
  objects.add(fighter);
  enemy=new Enemy();
  objects.add(enemy);
  rate=3;
  brate=1;
}

void createExplosion(float x, float y) {
  // 爆発エフェクトを生成
  for (int i = 0; i < 100; i++) {
    Particle p = new Particle(x, y);
    particles.add(p);
  }
}
