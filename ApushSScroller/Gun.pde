import java.util.Random;
import ddf.minim.*;

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
  
  void update(int x, int y) {
    this.x = x;
    this.y = y;
    this.cooldown -= 0.2;
    if (this.cooldown < 0) {
      this.cooldown = 0;
    }
  }
  
  void switchWeapons(int type) {
    this.type = type;
  }
    
  void render(int dir) {
    pushMatrix();
    translate(this.x, this.y);
    scale((2*dir-1) * 0.17, 0.17);
    translate(-this.x, -this.y);
    image(this.gunImages[this.type], this.x-110, this.y+45);
    popMatrix();
  }
  
  void fire(List<Bullet> bullets, int dir) {
    if(this.type == 0) {
      Bullet bullet = new Bullet(0, this.x, this.y, (2*dir-1) * 20, 0, this.type);
      bullets.add(bullet);
      this.cooldown = 3;
    } else if (this.type == 1) {
      for (int i = 0; i < 5; i++) {
        Bullet bullet = new Bullet(0, this.x, this.y, (2*dir-1) * 20, rnd.nextInt(6)-1, this.type);
        bullets.add(bullet);
      }
      this.cooldown = 8;
    } else if (this.type == 2) {
      Bullet bullet = new Bullet(0, this.x, this.y, (2*dir-1)* 30, 0, this.type);
      bullets.add(bullet);
      this.cooldown = 12;
    }
    this.gunSounds[this.type].rewind();
    this.gunSounds[this.type].play();
  }
}
