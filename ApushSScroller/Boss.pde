import java.lang.Math;
class Boss {
  int x, y, xv, yv, width, height;
  int health = 1000;
  Healthbar healthbar = new Healthbar(1000, 1, 400, 20);
  float frame = 0.00f;
  PImage bsprite;
  PImage attack;
  double shootingdir=0;
  double shootingdir2=30;
  double shootingdir3=60;
  double shootingdir4=90;
  double shootingdir5=120;
  double rotatingspeed=0.01;
  double shootingradius=8;
  int shootingintervals = 1;
  int shootingintervals2 = 5;
  int shootingintervals3 = 0;
  int shootingintervals4 = 5;
  int shootingintervals5 = 0;
  double shootingxv = 0;
  double shootingyv = 5;
  double shootingxv2 = 0;
  double shootingyv2= 5;
  double shootingxv3 = 0;
  double shootingyv3 = 5;
  double shootingxv4 = 0;
  double shootingyv4= 5;
  double shootingxv5 = 0;
  double shootingyv5 = 5;
  int bulletdmg = 2;
  List<Bossbullet> bbullets = new ArrayList<Bossbullet>();
  
  Boss() {
    bsprite = loadImage("characters/sputnik.png");
    attack = loadImage("backgrounds/reball.png");
    this.width = this.bsprite.width;
    this.height = this.bsprite.height;
    this.x = 450-160;
    this.y = 250-160;
  }
  
  
  void update(Player player, Stage stage) {
    shootingintervals+=1;
    shootingintervals2+=1;
    shootingdir+=rotatingspeed;
    shootingdir2+=rotatingspeed;
    shootingdir3+=rotatingspeed;
    shootingdir4+=rotatingspeed;
    shootingdir5+=rotatingspeed;
    shootingyv=Math.sin(shootingdir)*shootingradius;
    shootingxv=Math.cos(shootingdir)*shootingradius;
    shootingyv2=Math.sin(shootingdir2)*shootingradius;
    shootingxv2=Math.cos(shootingdir2)*shootingradius;
    shootingyv3=Math.sin(shootingdir3)*shootingradius;
    shootingxv3=Math.cos(shootingdir3)*shootingradius;
    shootingyv4=Math.sin(shootingdir4)*shootingradius;
    shootingxv4=Math.cos(shootingdir4)*shootingradius;
    shootingyv5=Math.sin(shootingdir5)*shootingradius;
    shootingxv5=Math.cos(shootingdir5)*shootingradius;
    if(shootingintervals%15==0){
      Bossbullet bbullet = new Bossbullet(this.x+this.width/2, this.y + this.height/2, shootingxv, shootingyv, 5);
      Bossbullet bbullet2 = new Bossbullet(this.x+this.width/2, this.y + this.height/2, shootingxv2, shootingyv2, 5);
      Bossbullet bbullet3 = new Bossbullet(this.x+this.width/2, this.y + this.height/2, shootingxv3, shootingyv3, 5);
      Bossbullet bbullet4 = new Bossbullet(this.x+this.width/2, this.y + this.height/2, shootingxv4, shootingyv4, 5);
      Bossbullet bbullet5 = new Bossbullet(this.x+this.width/2, this.y + this.height/2, shootingxv5, shootingyv5, 5);
      bbullets.add(bbullet);
      bbullets.add(bbullet2);
      bbullets.add(bbullet3);
      bbullets.add(bbullet4);
      bbullets.add(bbullet5);
    }
    if(shootingintervals2%180==0){
    for(double i = 0; i<360; i++){
      if(i%12==0){
        shootingyv=Math.sin(i)*6;
        shootingxv=Math.cos(i)*6;
        Bossbullet bbullet = new Bossbullet(this.x+this.width/2, this.y + this.height/2, shootingxv, shootingyv, 5);
        bbullets.add(bbullet);
      }
    }
    }
    for(int i=0; i<bbullets.size(); i++){
      if(bbullets.get(i).x>=player.x+5 && bbullets.get(i).x<=player.x+30 && bbullets.get(i).y<=player.y+44 && bbullets.get(i).y>=player.y){
        bbullets.remove(i);
        player.health-=2;
      }  
    }
    for(int i=0; i<stage.bullets.size(); i++){
      if(stage.bullets.get(i).x>=this.x+10 && stage.bullets.get(i).x<=this.x+this.width-10 && stage.bullets.get(i).y<=this.y+this.height && stage.bullets.get(i).y>=this.y){
        stage.bullets.remove(i);
        this.health-=stage.bullets.get(i).damage;
      }  
    }
  }

  void render(Player player) {
     image(bsprite, this.x, this.y);
     //this.boss.display(100, this.y-this.height, this.dir, frame);
     this.healthbar.render(this.health, this.x + this.width/2, this.y);
     //this.healthbar.render(this.health, 100 + this.width/2, this.y - this.height);
     for (int i = 0; i < this.bbullets.size(); i++) {
      bbullets.get(i).update();
      bbullets.get(i).render();
      if(bbullets.get(i).isOffScreen(900, 500)) {
        bbullets.remove(i);
      }
    }
  }
}
