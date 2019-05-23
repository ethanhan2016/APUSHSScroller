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
  
  void render() {
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

  void update(Player player) {
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
