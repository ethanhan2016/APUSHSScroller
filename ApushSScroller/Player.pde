
class Player{
  int x, y, xv, yv, width, height;
  int health = 100;
  int presidentNum = 0;
  int dir = 1;
  int xshift;
  int bottom;
  Minim minim;;
  Animation eisenhower = new Animation("eisenhower", 2);
  Healthbar healthbar = new Healthbar(100, 0, 70, 8);
  Gun gun;
  boolean left, right, up;
  boolean end = false;
  float frame = 0.00f;
  
  Player(int x, int y, AudioPlayer[] gunSounds) {
    this.width = this.eisenhower.width;
    this.height = this.eisenhower.height;
    this.x = x;
    this.y = y;
    this.gun = new Gun(0, 3, gunSounds);
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
  
  void fire(List<Bullet> bullets) {
    if(this.gun.cooldown == 0) {
      this.gun.fire(bullets, this.dir);
    }
  }
  
  void update(List<Bullet> bullets) {
    this.yv += 2;
    this.y += this.yv;
    if (this.y >= bottom) {
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
    if(xshift>=0 || (xshift<=0 && this.xv>0)){
      xshift += this.xv; 
    }
    if(end && this.x>=0 && this.x <=900-this.width){
      this.x+=this.xv;
    }
    this.gun.update(100 + this.width/2, this.y - this.height/2);
    if(mousePressed) {
      this.fire(bullets);
    }
  }
  
  void render() {
     if (this.presidentNum == 0) {
      this.eisenhower.display(this.x, this.y-this.height, this.dir, frame);
     }
     this.healthbar.render(this.health, this.x + this.width/2, this.y - this.height);
     this.gun.update(this.x+this.width/2+10,this.y-this.height+22);
     this.gun.render(this.dir);
  }
}
