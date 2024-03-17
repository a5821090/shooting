class Particle {
  PVector position;
  PVector velocity;
  color col;
  float lifespan;

  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(random(-2, 2), random(-5, -1)); // ランダムな速度
    col = color(random(255), random(255), random(255)); // ランダムな色
    lifespan = 255; // パーティクルの寿命
  }

  void update() {
    velocity.add(new PVector(0, 0.2)); // 重力をシミュレート
    position.add(velocity);
    lifespan -= 2; // 寿命を減少
  }

  void display() {
    noStroke();
    fill(col, lifespan);
    ellipse(position.x, position.y, 10, 10); // パーティクルを描画
  }

  boolean isDead() {
    return lifespan < 0; // パーティクルが死んだかどうかを判定
  }
}
