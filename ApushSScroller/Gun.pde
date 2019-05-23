class Gun {
  PImage gunImage;
  int type, height, width;
  
  Gun(int type) {
    this.type = type;
    this.gunImage = loadImage("guns/gun" + nf(type, 4) + ".png");
    
    this.width = this.gunImage.width;
    this.height = this.gunImage.height;
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
