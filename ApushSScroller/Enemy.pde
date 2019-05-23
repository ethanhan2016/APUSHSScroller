class Enemy {
  int x, y, xv, yv, width, height;
  int health = 100;
  int dir = 1;
  int bottom;
  boolean col;
  boolean close = false;
  Animation enemy = new Animation("scientist", 2);
  Healthbar healthbar = new Healthbar(100, 1, 70, 8);
  boolean left, right, up;
  float frame = 0.00f;
  
  Enemy(int x, int y) {
    this.width = this.enemy.width;
    this.height = this.enemy.height;
    this.x = x;
    this.y = y;
  }
  
  
  void update(Player player) {
    this.right=false;
    this.left=false;
    this.up=false;
    if(!col){
      if(player.x>=this.x-player.xshift-700 && player.x<=this.x-player.xshift+700){
        if(player.x>=this.x-player.xshift){
          this.right=true;
        }
        else if(player.x<=this.x-player.xshift){
          this.left=true;
        }
        if(player.y<this.y-10){
          this.up=true;
        }
      }
    }  
    this.yv += 2;
    this.y += this.yv;
    if (this.y > bottom) {
      this.y -= yv;
      if (this.up == true) {
        this.yv = -30;
      } else {
        this.yv = 0;
      }
    }
    this.xv = 0;
    if (this.left == true || this.right == true) {
      this.xv = (this.right) ? 2 : -2;
      this.dir = (this.right) ? 1 : 0;
      this.frame += 0.15;
    } else {
      this.frame = 0;
    }
    this.x+=this.xv;
    col=false;
  }
  
  boolean checkCollisionOther(Enemy enemy, Player player){
    if(enemy.x-player.xshift<=this.x-player.xshift+this.width+10 && enemy.x-player.xshift>=this.x-player.xshift-this.width-10 && (checkCollisionPlayer(player) || enemy.close || enemy.checkCollisionPlayer(player))){
      this.close=true;
      return true;
    }
    this.close=false;
    return false;
  }  
  
  boolean checkCollisionPlayer(Player player){
    if(player.x>=this.x-player.xshift-10 && player.x<=this.x-player.xshift+10+this.width){
      this.close=true;
      return true;
    }
    this.close=false;
    return false;
  }  
  void render() {
    if (this.health > 0) {
       this.enemy.display(this.x-player.xshift, this.y - this.height, this.dir, frame);
       //this.enemy.display(100, this.y-this.height, this.dir, frame);
       this.healthbar.render(this.health, this.x-player.xshift + this.width/2, this.y - this.height);
       //this.healthbar.render(this.health, 100 + this.width/2, this.y - this.height);
    }
  }
}
