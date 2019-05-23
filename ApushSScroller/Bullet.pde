class Bullet {
  int x, y, xv, yv, type, damage;
  
  Bullet(int x, int y, int xv, int yv, int type) {
    this.type = type;
    this.x = x;
    this.y = y;
    this.xv = xv;
    this.yv = yv;
    
    if(this.type == 0) {
      this.damage = 5;
    } else if(this.type == 1) {
      this.damage = 3;
    } else if(this.type == 2) {
      this.damage = 12;
    }
  }
  
  void update() {
    this.x += this.xv;
    this.y -= this.yv;
  }
  
  void render() {
    fill(255);
    noStroke();
    if(this.type == 2) {
      rect(this.x, this.y, 10, 5);
    } else {
      ellipse(this.x, this.y, 10, 10);
      }
   }
  
  boolean isOffScreen(int width, int height) {
    return (this.x < 0 || this.x > width || this.y < 0 || this.y > height);
  }
}
