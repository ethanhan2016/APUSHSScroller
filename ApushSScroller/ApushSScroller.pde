Player player;
Stage stage;
Background background;
Enemy enemy;

void settings() {
  size(900, 500);
}
void setup() {
  player = new Player(100, 455);
  enemy = new Enemy(300, 455);
  background = new Background("ssbackground");
  stage = new Stage(15, 30);
}

void draw() {
  clear();
  background(255);
  stage.render(0, 0, player.xshift, background, player);
  player.update(stage.bullets);
  player.render();
  stage.updateBullets();
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
  
}

void keyReleased() {
  player.setMove(keyCode, false);
}
