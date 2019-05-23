class Endscreen {
  PImage win;
  Endscreen(){
    this.win = loadImage("Title/Win.png");
  }
  
  void render(){
    background(0, 40,78);
    image(this.win, 100, 100);
  }
}
