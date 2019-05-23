class Cbottle {
  
  PImage cbottle;
  int x, y, xv, yv, damage;
  
  Cbottle(int x, int y, int xv, int yv) {
    this.x = x;
    this.y = y;
    this.xv = xv;
    this.yv = yv;
    this.damage = 5;
    cbottle=loadImage("guns/cokebottle.png");
  }
  
  void render() {
    this.yv -=2;
    this.x += this.xv;
    this.y -= this.yv;
    image(cbottle,this.x,this.y);
   }
  
  boolean isonbottom(Enemy enemy) {
    return (this.y < enemy.bottom);
  }
}
