Player player;
Stage stage;
Background background;
Enemy enemy;
import ddf.minim.*;
Minim minim;
AudioPlayer[] themePlayers = new AudioPlayer[2];
AudioPlayer[] gunSounds = new AudioPlayer[3];

void settings() {
  size(900, 500);
}
void setup() {
  minim = new Minim(this);
  
  themePlayers[0] = minim.loadFile("sounds/main.mp3");
  themePlayers[1] = minim.loadFile("sounds/boss.mp3");
  for (int i = 0; i < 3; i++) {
    gunSounds[i] = minim.loadFile("sounds/gun" + nf(i, 4) + ".mp3");
  }
  themePlayers[1].play();
  player = new Player(100, 455, gunSounds);
  enemy = new Enemy(300, 455);
  background = new Background("ssbackground");
  stage = new Stage(15, 5);
}

void draw() {
  clear();
  background(255);
  stage.render(0, 0, player.xshift, background, player);
  if(player.health>0){
  player.update(stage.bullets);
  player.render();
  stage.updateBullets();
  stage.checkBECollisions(player);
  }
}

void keyPressed() {
  player.setMove(keyCode, true);
  if(key == 'j') {
    player.dir = 1 - player.dir;
  }
  if(keyCode == 32) {
    player.fire(stage.bullets);
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

void keyReleased() {
  player.setMove(keyCode, false);
}
