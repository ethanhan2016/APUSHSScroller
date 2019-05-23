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
  stage = new Stage(20, 50);
}

void draw() {
  clear();
  background(255);
  stroke(0);
  strokeWeight(1);
  line(0,700,1800,700);
  noStroke();
  stage.render(0, 0, player.xshift, background, player);
  player.bottom = stage.checkPCollision(player);
  player.update();
  player.render();
}

void keyPressed() {
  player.setMove(keyCode, true);
  if(key == 'j') {
    player.dir = 1 - player.dir;
  }
}

void keyReleased() {
  player.setMove(keyCode, false);
}
