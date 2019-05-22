class Animation {
 PImage[] images;
  int imageCount, width, height;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage("presidents/" + filename);
    }
    
    this.width = images[0].width;
    this.height = images[0].height;
  }

  void display(int x, int y, int dir, float frame) {
    if (dir == 1) {
      image(images[floor(frame) % this.imageCount], x, y);
    } else if (dir == 0) {
      pushMatrix();
      scale(-1, 1);
      image(images[floor(frame) % this.imageCount], -x - this.width, y);
      popMatrix();
    }
  }
  
  int getWidth() {
    return images[0].width;
  } 
  
  int getHeight() {
    return images[0].height;
  } 
}
