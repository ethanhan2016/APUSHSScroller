class Bossbullet {
  int team, x, y, xv, yv, type, damage;
  
  Bossbullet(int x, int y, int xv, int yv) {
    this.x = x;
    this.y = y;
    this.xv = xv;
    this.yv = yv;
  }
  
  void update() {
    this.x += this.xv;
    this.y += this.yv;
  }
  
  void render() {
    fill(255,0,0);
    noStroke();
    ellipse(this.x, this.y, 7, 7);
   }
  
  boolean isOffScreen(int width, int height) {
    return (this.x < 0 || this.x > width || this.y < 0 || this.y > height);
  }
}
