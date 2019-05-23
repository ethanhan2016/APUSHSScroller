class Bullet {
  int team, x, y, xv, yv, type, damage;
  
  Bullet(int team, int x, int y, int xv, int yv, int type) {
    this.type = type;
    this.x = x;
    this.y = y;
    this.xv = xv;
    this.yv = yv;
    this.type = type;
    
    switch(this.type) {
      case 0:
        this.damage = 5;
      case 1:
        this.damage = 3;
      case 2:
        this.damage = 12;
      default:
        this.damage = 5;;
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
