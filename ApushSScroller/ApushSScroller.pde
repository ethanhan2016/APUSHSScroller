Player player;

void settings() {
  size(1800,1000);
}
void setup() {
  player = new Player(100, 700);
}

void draw() {
  clear();
  background(255);
  stroke(0);
  strokeWeight(1);
  line(0,700,1800,700);
  noStroke();
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
