class Gun {
  PImage gunImage;
  int type, height, width;
  float frame = 0.00f;
  Gun(int type) {
    this.type = type;
    this.gunImage = loadImage("guns/gun" + nf(type, 4) + ".png");
    
    this.width = this.gunImage.width;
    this.height = this.gunImage.height;
  }
  
  void update() {
    this.frame += 0.15;
  }
  
  void render(int x, int y, int dir) {
    pushMatrix();
    translate(x, y);
    scale((2*dir-1) * 0.17, 0.17);
    translate(-x, -y);
    image(this.gunImage, x-110, y+45);
    popMatrix();
  }
}
