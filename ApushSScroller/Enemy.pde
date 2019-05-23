class Enemy {
  int x, y, xv, yv, width, height;
  int health = 100;
  int dir = 1;
  int mapx;
  Animation eisenhower = new Animation("eisenhower", 2);
  Healthbar healthbar = new Healthbar(100, 0, 70, 8);
  Gun gun = new Gun(0, 0.2);
  boolean left, right, up;
  float frame = 0.00f;
  
  Enemy(int x, int y) {
    this.width = this.eisenhower.width;
    this.height = this.eisenhower.height;
    this.x = x;
    this.y = y;
  }
  
  boolean setMove(int k, boolean b) {
    switch (k) {
    case 'W':
    case UP:
      return up = b;
 
    case 'A':
    case LEFT:
      return left = b;
 
    case 'D':
    case RIGHT:
      return right = b;
 
    default:
      return b;
    }
  }
  
  void update() {
    this.yv += 2;
    this.y += this.yv;
    if (this.y > 460) {
      this.y -= yv;
      if (this.up == true) {
        this.yv = -30;
      } else {
        this.yv = 0;
      }
    }
    this.xv = 0;
    if (this.left == true || this.right == true) {
      this.xv = (this.right) ? 7 : -7;
      this.dir = (this.right) ? 1 : 0;
      this.frame += 0.15;
    } else {
      this.frame = 0;
    }
    if(mapx>=0 || (mapx<=0 && this.xv>0)){
      mapx += this.xv;
    }
    this.x += this.xv;
  }
  
  void render() {
      //this.eisenhower.display(this.x, this.y - this.height, this.dir, frame);
     this.eisenhower.display(100, this.y-this.height, this.dir, frame);
     //this.healthbar.render(this.health, this.x + this.width/2, this.y - this.height);
     this.healthbar.render(this.health, 100 + this.width/2, this.y - this.height);
     //this.gun.render(this.x + this.width/2, this.y - this.height/2, this.dir);
     //this.gun.render(100 + this.width/2, this.y - this.height/2, this.dir);
  }
}
