class Healthbar {
  int maxHealth, type, length, width;
  
  Healthbar(int maxHealth, int type, int length, int width) {
    this.maxHealth = maxHealth;
    this.type = type;
    this.length = length;
    this.width = width;
  }
  
  void render(int currentHealth, int x, int y) {
    fill(95 + 160*this.type, 220 - 220*this.type, 0);
    rect(x - this.length/2, y - 20, (float) currentHealth/this.maxHealth * this.length, this.width);
    noFill();
    stroke(0);
    strokeWeight(0.25);
    rect(x - this.length/2, y - 20, this.length, this.width);
    noStroke();
  }
}
