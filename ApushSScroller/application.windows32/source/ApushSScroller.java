import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.lang.Math; 
import java.util.Random; 
import ddf.minim.*; 
import ddf.minim.*; 
import java.util.Random; 
import java.util.ArrayList; 
import java.util.List; 
import java.util.ListIterator; 
import java.util.Arrays; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ApushSScroller extends PApplet {

Player player;
Stage stage;
Background background;
Enemy enemy;
Sound sound;
Title title;
Endscreen es;
int game = 0;

public void settings() {
  size(900, 500);
}
public void setup() {
  es = new Endscreen();
  sound = new Sound(this);
  title = new Title();
    player = new Player(100, 455, sound.gunSounds);
    enemy = new Enemy(300, 455);
    background = new Background("ssbackground");
    stage = new Stage(15, 30);
}

public void draw() {
  if (game == 0) {
    title.update(player);
    title.render();
    
  } else if(game == 1) {
    clear();
    background(255);
    stage.render(0, 0, player.xshift, background, player);
    if(player.health>0){
      player.update(stage.bullets, stage);
      player.render();
      stage.updateBullets();
      stage.checkBECollisions(player);
    }
    if(stage.bosshealth()<=0){
      game=2;
    }
  }
  else if (game==2){
    es.render();
  }
}

public void keyPressed() {
  player.setMove(keyCode, true);
  if(key == 'j') {
    player.dir = 1 - player.dir;
  }
  if(keyCode == 32) {
    if(game == 0) {
      player.presidentNum = title.playerType;
      game = 1;
    } else if (game == 1) {
      player.fire(stage.bullets);
    }
  }
  if(key == '1') {
    player.gun.switchWeapons(0);
  }
  if(key == '2') {
    player.gun.switchWeapons(1);
  }
  if(key == '3') {
    player.gun.switchWeapons(2);
  }
  if(key == 'r') {
    stage.reset(player, background);
  }
  
}

public void keyReleased() {
  player.setMove(keyCode, false);
}
class Animation {
 PImage[] images;
  int imageCount, width, height;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage("characters/" + filename);
    }
    
    this.width = images[0].width;
    this.height = images[0].height;
  }

  public void display(int x, int y, int dir, float frame) {
    if (dir == 1) {
      image(images[floor(frame) % this.imageCount], x, y);
    } else if (dir == 0) {
      pushMatrix();
      scale(-1, 1);
      image(images[floor(frame) % this.imageCount], -x - this.width, y);
      popMatrix();
    }
  }
  
  public int getWidth() {
    return images[0].width;
  } 
  
  public int getHeight() {
    return images[0].height;
  } 
}
class Background {
  PImage s1background;
  PImage s2background;
  int  width, height, displaywidth, displayheight;
  boolean stage1clear=false;;
  boolean stage2clear=false;;
  boolean first=false;
  boolean other = true;
  boolean end = false;
  int gstate = 0;
  
  Background(String file) {
    String filename = file + ".png";
    s1background = loadImage("backgrounds/" + filename);
    s2background = loadImage("backgrounds/bossapush.png");
    this.width = s1background.width;
    this.height = s1background.height;
    stage1clear=false;
  }

  public void display(int x, int y, int xshift, Player player) {
    if(player.health<=0){
      background(255);
      fill(0);
      textAlign(CENTER);
      text("Game Over.", 450,100);
      text("Press R to try again.", 450, 200);
    }
    else if((x+xshift>=7700 && !stage1clear && other && gstate==0) || (end == true && !stage1clear && other)){
      player.end=true;
      image(s1background.get(7700, y, 900, 500), 0, 0);
      if(player.xv==7){
        player.xshift-=7;
      }
      if(player.xv==-7){
        player.xshift+=7;
      }
      end = true;
      if(player.x==100){
        end = false;
      }
      if(player.x>=800){
        stage1clear=true;
        end = false;
        first = true;
      }
    }
    else if(stage1clear && first && !end && other && gstate==0){
      player.end=false;
      player.xshift = 8600;
      xshift = 8600;
      first=false;
      player.x=100;
      other = false;
      image(s1background.get(x+xshift, y, 900, 500), 0, 0);
    }
    else if(gstate==0 && (x+xshift>=11600 && !stage2clear) || end==true){
      image(s1background.get(11600, y, 900, 500), 0, 0);
      player.end=true;
      if(player.xv==7){
        player.xshift-=7;
      }
      if(player.xv==-7){
        player.xshift+=7;
      }
      end = true;
      if(player.x==100){
        end = false;
      }
      if(player.x>=800){
        stage2clear=true;
        end = false;
        first = true;
      }
      stage1clear=false;
    }
    else if(stage2clear && first && !end && gstate==0){
      player.end=true;
      player.xshift = 8600;
      xshift = 8600;
      first=false;
      player.x=100;
      image(s2background, 0, 0);
      gstate=1;
    }
    else if(gstate==1){
      player.end=true;
      image(s2background, 0, 0);
      if(player.xv==7){
        player.xshift-=7;
      }
      if(player.xv==-7){
        player.xshift+=7;
      }
    }  
    else if(x+xshift>=0 && !end){
      player.end=false;
      image(s1background.get(x+xshift, y, 900, 500), 0, 0);
    }
    else {
      player.end=false;
      image(s1background.get(0, y , 900, 500), 0, 0);
    }
  }
  
  public int getWidth() {
    return s1background.width;
  } 
  
  public int getHeight() {
    return s1background.height;
  } 
}

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
  double rotatingspeed=0.01f;
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
  int bulletdmg = 4;
  List<Bossbullet> bbullets = new ArrayList<Bossbullet>();
  
  Boss() {
    bsprite = loadImage("characters/sputnik.png");
    attack = loadImage("backgrounds/reball.png");
    this.width = this.bsprite.width;
    this.height = this.bsprite.height;
    this.x = 450-160;
    this.y = 250-160;
  }
  
  
  public void update(Player player, Stage stage) {
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
        player.health-=bulletdmg;
      }  
    }
    for(int i=0; i<stage.bullets.size(); i++){
      if(stage.bullets.get(i).x>=this.x+10 && stage.bullets.get(i).x<=this.x+this.width-10 && stage.bullets.get(i).y<=this.y+this.height && stage.bullets.get(i).y>=this.y){
        this.health-=stage.bullets.get(i).damage;
        stage.bullets.remove(i);
      }  
    }
  }

  public void render(Player player) {
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
class Bossbullet {
  double x, y, xv, yv;
  int time;
  
  Bossbullet(int x, int y, double xv, double yv, int time) {
    this.time = time;
    this.x = x;
    this.y = y;
    this.xv = xv;
    this.yv = yv;
  }
  
  public void update() {
    this.time-=1;
      if(this.time>=0){
      this.xv=this.xv*0.9f;
      this.yv=this.yv*0.9f;
      }
    this.x += this.xv;
    this.y += this.yv;
  }
  
  public void render() {
    fill(255,0,0);
    noStroke();
    ellipse((float) this.x, (float) this.y, 10, 10);
   }
  
  public boolean isOffScreen(int width, int height) {
    return (this.x < 0 || this.x > width || this.y < 0 || this.y > height);
  }
}
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
  
  public void update() {
    this.x += this.xv;
    this.y -= this.yv;
  }
  
  public void render() {
    fill(255);
    noStroke();
    if(this.type == 2) {
      rect(this.x, this.y, 10, 5);
    } else {
      ellipse(this.x, this.y, 10, 10);
      }
   }
  
  public boolean isOffScreen(int width, int height) {
    return (this.x < 0 || this.x > width || this.y < 0 || this.y > height);
  }
}
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
  
  public void render() {
    this.yv -=2;
    this.x += this.xv;
    this.y -= this.yv;
    image(cbottle,this.x,this.y);
   }
  
  public boolean isonbottom(Enemy enemy) {
    return (this.y < enemy.bottom);
  }
}
class Damage{
  Damage(){
  }
  
  public void PlayertoMob(Player player, Enemy enemy, Stage stage, int index){
    enemy.health -= stage.bullets.get(index).damage;
  }
  
  public void MobtoPlayer(Player player, Enemy enemy) {
    player.health -= enemy.damage;
  }
  
  public void PlayertoBoss(Player player, Boss boss, Stage stage, int index){
    boss.health -= stage.bullets.get(index).damage;
  }
  
  public void BosstoPlayer(Player player, Boss boss, int index){
    player.health -= boss.bulletdmg;
  }
}
class Endscreen {
  PImage win;
  Endscreen(){
    this.win = loadImage("Title/Win.png");
  }
  
  public void render(){
    background(0, 40,78);
    image(this.win, 100, 100);
  }
}
Cbottle cbottle;
class Enemy {
  int x, y, xv, yv, width, height;
  int health = 100;
  int dir = 1;
  int bottom;
  boolean col;
  boolean close = false;
  int damage;
  Animation enemy = new Animation("scientist", 2);
  Healthbar healthbar = new Healthbar(100, 1, 70, 8);
  boolean left, right, up;
  boolean cbottleon = false;
  float frame = 0.00f;
  int attackinterval = 300;
  
  
  Enemy(int x, int y) {
    this.width = this.enemy.width;
    this.height = this.enemy.height;
    this.x = x;
    this.y = y;
    cbottle = new Cbottle(0,0,0,0);
  }
  
  
  public void update(Player player) {
    attackinterval+=1;
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
      this.frame += 0.15f;
    } else {
      this.frame = 0;
    }
    if(this.checkCollisionPlayer(player)){
      this.xv=0;
    }
    this.x+=this.xv;
    col=false;
    if((this.y>=player.y-20 && this.y<=player.y+10 && this.attackinterval>=500 && this.x-player.xshift>=player.x-30 && this.x-player.xshift<=player.x+10 )){
      cbottle.x=this.x-player.xshift;
      cbottle.y=this.y-100;
      if(this.x-player.xshift>player.x){
      cbottle.xv=-4;
      }
      if(this.x-player.xshift<player.x){
         cbottle.xv=4;
      }
      cbottle.yv=20;
      cbottleon = true;
      player.health -=1;
      attackinterval=0;
    }
  }
  
  public boolean checkCollisionOther(Enemy enemy, Player player){
    if(enemy.x-player.xshift<=this.x-player.xshift+this.width+10 && enemy.x-player.xshift>=this.x-player.xshift-this.width-10 && (checkCollisionPlayer(player) || enemy.close || enemy.checkCollisionPlayer(player))){
      this.close=true;
      return true;
    }
    this.close=false;
    return false;
  }  
  
  public boolean checkCollisionPlayer(Player player){
    if(player.x>=this.x-player.xshift-10 && player.x<=this.x-player.xshift+10+this.width){
      this.close=true;
      return true;
    }
    this.close=false;
    return false;
  }  
  public void render() {
    if (this.health > 0) {
       this.enemy.display(this.x-player.xshift, this.y - this.height, this.dir, frame);
       //this.enemy.display(100, this.y-this.height, this.dir, frame);
       this.healthbar.render(this.health, this.x-player.xshift + this.width/2, this.y - this.height);
       //this.healthbar.render(this.health, 100 + this.width/2, this.y - this.height);
       if(!cbottle.isonbottom(this)){
         cbottle.render();
       }
       else{
         cbottleon=false;
       }
    }
  }
}



class Gun {
  PImage[] gunImages;
  int type, height, width, x, y;
  float cooldown;
  Random rnd = new Random();
  AudioPlayer[] gunSounds;
  
  Gun(int type, float cooldown, AudioPlayer[] gunSounds) {
    this.type = type;
    this.cooldown = cooldown;
    this.gunSounds = gunSounds;
    this.gunImages = new PImage[3];
      for(int i = 0; i < 3; i++) {
        gunImages[i] = loadImage("guns/gun" + nf(i, 4) + ".png");
      }
    
    this.width = this.gunImages[this.type].width;
    this.height = this.gunImages[this.type].height;
  }
  
  public void update(int x, int y) {
    this.x = x;
    this.y = y;
    this.cooldown -= 0.2f;
    if (this.cooldown < 0) {
      this.cooldown = 0;
    }
  }
  
  public void switchWeapons(int type) {
    this.type = type;
  }
    
  public void render(int dir) {
    pushMatrix();
    translate(this.x, this.y);
    scale((2*dir-1) * 0.17f, 0.17f);
    translate(-this.x, -this.y);
    image(this.gunImages[this.type], this.x-110, this.y+45);
    popMatrix();
  }
  
  public void fire(List<Bullet> bullets, int dir) {
    if(this.type == 0) {
      Bullet bullet = new Bullet(this.x, this.y, (2*dir-1) * 20, 0, this.type);
      bullets.add(bullet);
      this.cooldown = 3;
    } else if (this.type == 1) {
      for (int i = 0; i < 5; i++) {
        Bullet bullet = new Bullet(this.x, this.y, (2*dir-1) * 20, rnd.nextInt(6)-1, this.type);
        bullets.add(bullet);
      }
      this.cooldown = 8;
    } else if (this.type == 2) {
      Bullet bullet = new Bullet(this.x, this.y, (2*dir-1)* 30, 0, this.type);
      bullets.add(bullet);
      this.cooldown = 14;
    }
    this.gunSounds[this.type].rewind();
    this.gunSounds[this.type].play();
  }
}
class Healthbar {
  int maxHealth, type, length, width;
  
  Healthbar(int maxHealth, int type, int length, int width) {
    this.maxHealth = maxHealth;
    this.type = type;
    this.length = length;
    this.width = width;
  }
  
  public void render(int currentHealth, int x, int y) {
    fill(95 + 160*this.type, 220 - 220*this.type, 0);
    rect(x - this.length/2, y - 20, (float) currentHealth/this.maxHealth * this.length, this.width);
    noFill();
    stroke(0);
    strokeWeight(0.25f);
    rect(x - this.length/2, y - 20, this.length, this.width);
    noStroke();
  }
}
class Platform {
  PImage platform;
  int width, height, displaywidth, displayheight;
  int x,y;
  
  Platform(String file, int x, int y) {
    String filename = file + ".png";
    platform = loadImage("backgrounds/" + filename);
    
    this.x=x;
    this.y=y;
 
    this.width = platform.width;
    this.height = platform.height;
  }

  public void display(int xshift) {
    if(x+xshift>=0){
      image(platform, this.x-xshift, this.y);
    }
    else if(x+xshift>12500){
      image(platform, this.x-xshift, this.y);
    }
    else if(x+xshift<0){
      image(platform, this.x, this.y);
    }
  }
  
  
  public int getWidth() {
    return platform.width;
  } 
  
  public int getHeight() {
    return platform.height;
  } 
}

class Player{
  int x, y, xv, yv, width, height;
  int health = 100;
  int presidentNum = 0;
  int dir = 1;
  int xshift;
  int bottom;
  Minim minim;;
  Animation eisenhower = new Animation("eisenhower", 2);
  Animation kennedy = new Animation("kennedy", 2);
  Healthbar healthbar = new Healthbar(100, 0, 70, 8);
  Gun gun;
  boolean left, right, up;
  boolean end = false;
  float frame = 0.00f;
  
  Player(int x, int y, AudioPlayer[] gunSounds) {
    this.width = (this.presidentNum == 0) ? this.eisenhower.width : this.kennedy.width;
    this.height =(this.presidentNum == 0) ? this.eisenhower.height : this.kennedy.height;
    this.x = x;
    this.y = y;
    this.gun = new Gun(0, 3, gunSounds);
  }
  
  public boolean setMove(int k, boolean b) {
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
  
  public void fire(List<Bullet> bullets) {
    if(this.gun.cooldown == 0) {
      this.gun.fire(bullets, this.dir);
    }
  }
  
  public void update(List<Bullet> bullets, Stage stage) {
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
      this.frame += 0.15f;
    } else {
      this.frame = 0;
    }
    if(xshift>=0 || (xshift<=0 && this.xv>0)){
      xshift += this.xv; 
    }
    if(this.x<0){
      this.x=0;
    }
    if(this.x>990-this.width){
      this.x=990-this.width;
    }
    if(end && this.x>=0 && this.x <=900-this.width){
      this.x+=this.xv;
    }
    this.gun.update(100 + this.width/2, this.y - this.height/2);
    if(mousePressed) {
      this.fire(bullets);
    }
  }
  
  public void render() {
     if (this.presidentNum == 0) {
      this.eisenhower.display(this.x, this.y-this.height, this.dir, frame);
     } else if (this.presidentNum == 1) {
       this.kennedy.display(this.x, this.y-this.height, this.dir, frame);
     }
     this.healthbar.render(this.health, this.x + this.width/2, this.y - this.height);
     this.gun.update(this.x+this.width/2+10,this.y-this.height+22);
     this.gun.render(this.dir);
  }
}


class Sound {
  Minim minim;
  AudioPlayer[] themePlayers = new AudioPlayer[2];
  AudioPlayer[] gunSounds = new AudioPlayer[3];
  AudioPlayer[] hitSounds = new AudioPlayer[2];;
  
  Sound(ApushSScroller apushsscroller) {
    minim = new Minim(apushsscroller);
    hitSounds[0] = minim.loadFile("sounds/hurt.mp3");
    hitSounds[1] = minim.loadFile("sounds/death.mp3");
    themePlayers[0] = minim.loadFile("sounds/main.mp3");
    themePlayers[0].setGain(-25);
    themePlayers[1] = minim.loadFile("sounds/boss.mp3");
    for (int i = 0; i < 3; i++) {
      gunSounds[i] = minim.loadFile("sounds/gun" + nf(i, 4) + ".mp3");
    }
    themePlayers[0].loop();
  }
}
Platform platform;
Enemy enemyclass;
Boss boss1;






class Stage {
  Platform[] parray;
  Platform[] parray1;
  Enemy[] earray;
  int enumber;
  int platnumber;
  int c = 1;
  List<Bullet> bullets = new ArrayList<Bullet>();
  ListIterator<Bullet> bulletIterator = null;
  
  Random rnd = new Random();
  
  Stage(int platnumber, int enumber) {
    this.platnumber = platnumber;
    parray = new Platform[platnumber];
    for(int i=0; i<platnumber; i++){
      parray[i] = new Platform("ssplatforms", rnd.nextInt(12500), rnd.nextInt(300)+120);
    }  
    this.enumber = enumber;
    earray = new Enemy[enumber];
    for(int i=0; i<enumber; i++){
      earray[i] = new Enemy(rnd.nextInt(12500), rnd.nextInt(300)+150);
    }  
    parray1 = new Platform [6];
    for(int i=0; i<6; i++){
      parray1[i]= new Platform("ssplatforms", 400*c-250, 150*((i+1)%3)+50);
      if(i==2){
        c=2;
      }
    }
    c=1;
    boss1 = new Boss();
  }
  
  public void updateBullets() {
    bulletIterator = bullets.listIterator();
    while(bulletIterator.hasNext()) {
      Bullet bullet = bulletIterator.next();
      bullet.update();
      bullet.render();
      if(bullet.isOffScreen(900, 500)) {
        bulletIterator.remove();
      }
    }
  }
  
  public void checkBECollisions(Player player) {
    bulletIterator = bullets.listIterator();
    while(bulletIterator.hasNext()) {
      Bullet bullet = bulletIterator.next();
      for (int j = 0; j < this.earray.length; j++) {
        if(earray[j].health > 0) {
          if(bullet.x >= earray[j].x - player.xshift && bullet.x <= earray[j].x - player.xshift + earray[j].width && bullet.y <= earray[j].y && bullet.y >= earray[j].y - earray[j].height) {
            print(bullet.damage);
            earray[j].health -= bullet.damage;
            if (bullet.type == 0 || bullet.type == 1) {
              bulletIterator.remove();
              break;
            }
          }
        }
      }
    }
  }
  
  public int checkPCollision(Player player, Platform[] parray0){
    int maxY = 455;
    for(int a=0; a<parray0.length; a++){
      if(player.y <= parray0[a].y && player.x >= parray0[a].x-player.xshift-player.width && player.x <= parray0[a].x-player.xshift+parray0[a].width){
        maxY = (parray0[a].y < maxY) ? parray0[a].y : maxY;
      }  
    }
    return(maxY);
  }  
  
  public int checkECollision(Enemy enemy){
    int maxY = 455;
    for(int a=0; a<platnumber; a++){
      if(enemy.y <= parray[a].y && enemy.x >= parray[a].x && enemy.x <= parray[a].x+parray[a].width){
        maxY = (parray[a].y < maxY) ? parray[a].y : maxY;
      }  
    }
    return(maxY);
  }  
  
  public void reset(Player player, Background background){
    boss1.health=1000;
    player.health=100;
    background.other=true;
    background.first=true;
    background.gstate=0;
    background.stage1clear=false;
    background.stage2clear=false;
    background.end=false;
    Arrays.fill( parray, null );
    Arrays.fill( parray1, null );
    Arrays.fill( earray, null);
    parray = new Platform[platnumber];
    for(int i=0; i<platnumber; i++){
      parray[i] = new Platform("ssplatforms", rnd.nextInt(12500), rnd.nextInt(300)+120);
    }  
    earray = new Enemy[enumber];
    for(int i=0; i<enumber; i++){
      earray[i] = new Enemy(rnd.nextInt(12500), rnd.nextInt(300)+150);
    }  
    parray1 = new Platform [6];
    for(int i=0; i<6; i++){
      parray1[i]= new Platform("ssplatforms", 400*c-250, 150*((i+1)%3)+50);
      if(i==2){
        c=2;
      }
    }
    boss1.bbullets.clear();
  }
  
  public int bosshealth(){
    return boss1.health;
  }
  
  public void render(int x, int y, int xshift, Background background, Player player) {
    background.display(x, y, xshift, player);
    if(player.health>0){
    if(background.gstate==0){  
    player.bottom = this.checkPCollision(player,parray);
    for(int j=0; j<platnumber; j++){
      parray[j].display(player.xshift);
    }
    for(int i=0; i<enumber; i++){
      earray[i].bottom = this.checkECollision(earray[i]);
      for(int j=0; j<enumber; j++){
        if(earray[i].checkCollisionOther(earray[j],player)==true && !(i==j)){
          earray[i].col=true;
        }
      }
      earray[i].update(player);
      earray[i].render();
      if(earray[i].checkCollisionPlayer(player)){
        player.xv=0;
      }
    }
    }
    else{
      player.xshift=0;
      player.bottom =this.checkPCollision(player,parray1);
      boss1.update(player, this);
      boss1.render(player);
      for(int i=0; i<6; i++){
        parray1[i].display(0);
      }
      boss1.healthbar.render(boss1.health, boss1.x + boss1.width/2, boss1.y);
    }
    }
  }
  
}
class Title {
  
  PImage title, select, eisenhower, kennedy, play, eisenhowerFull, kennedyFull;
  int playerType = 1;
  
  Title() {
    this.title = loadImage("Title/Title.png");
    this.select = loadImage("Title/select.png");
    this.eisenhower = loadImage("Title/Eisenhower.png");
    this.eisenhowerFull = loadImage("presidents/eisenhower0000.png");
    this.kennedy = loadImage("Title/Kennedy.png");
    this.kennedyFull = loadImage("presidents/kennedy0000.png");
    this.play = loadImage("Title/Play.png");
  }
  
  public void render() {
    background(0, 40,78);
    image(this.title, 317, 50);
    image(this.select, 319, 160);
    noStroke();
    fill(216, 185, 127);
    rect(172 + 412*this.playerType, 205 - 12*this.playerType, 106 + 12*this.playerType, 138+12*this.playerType);
    image(this.eisenhower, 100, 360);
    image(this.eisenhowerFull, 197, 230);
    image(this.kennedy, 550, 360);
    image(this.kennedyFull, 609, 218);
    image(this.play, 258, 450);
    
  }

  public void update(Player player) {
    if (mousePressed) {
      if(mouseX >= 197 && mouseX <= 253 && mouseY >= 230 && mouseY <= 318) {
        this.playerType = 0;
      } else if (mouseX >= 609 && mouseX <= 697 && mouseY >= 218 && mouseY <= 318) {
        this.playerType = 1;
      } else {
        player.presidentNum = this.playerType;
        game = 1;
      }
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ApushSScroller" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
