Player player;
Stage stage;
Background background;
Enemy enemy;
Sound sound;
Title title;
Endscreen es;
int game = 0;

void settings() {
  size(900, 500);
}
void setup() {
  es = new Endscreen();
  sound = new Sound(this);
  title = new Title();
    player = new Player(100, 455, sound.gunSounds);
    enemy = new Enemy(300, 455);
    background = new Background("ssbackground");
    stage = new Stage(15, 30);
}

void draw() {
  if (game == 0) {
    title.update(player);
    title.render();
    
  } else if(game == 1) {
    clear();
    background(255);
    stage.render(0, 0, player.xshift, background, player);
    if(player.health>0){
      player.update(stage.bullets);
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

void keyPressed() {
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

void keyReleased() {
  player.setMove(keyCode, false);
}
