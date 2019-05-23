class Boss {
  int x, y, xv, yv, width, height;
  int health = 1000;
  Healthbar healthbar = new Healthbar(1000, 1, 400, 20);
  float frame = 0.00f;
  PImage bsprite;
  PImage attack;
  int shootingdir=0;
  int rotatingspeed=1;
  int shootingintervals = 30;
  int shootingxv = 0;
  int shootingyv = 5;
  List<Bossbullet> bbullets = new ArrayList<Bossbullet>();
  
  
  Boss() {
    bsprite = loadImage("characters/sputnik.png");
    attack = loadImage("backgrounds/reball.png");
    this.width = this.bsprite.width;
    this.height = this.bsprite.height;
    this.x = 450-160;
    this.y = 250-160;
  }
  
  
  void update(Player player) {
    shootingintervals+=1;
    shootingdir+=rotatingspeed;
    Bossbullet bbullet = new Bossbullet(this.x+this.width/2, this.y - this.height/2, shootingxv, shootingyv);
    bbullets.add(bbullet);
  }

  void render(Player player) {
     image(bsprite, this.x, this.y);
     //this.boss.display(100, this.y-this.height, this.dir, frame);
     this.healthbar.render(this.health, this.x + this.width/2, this.y);
     //this.healthbar.render(this.health, 100 + this.width/2, this.y - this.height);
  }
}
