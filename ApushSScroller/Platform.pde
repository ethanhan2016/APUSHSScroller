class Platform {
  PImage platform;
  int width, height, displaywidth, displayheight;
  int x,y;
  
  Platform(String file, int x, int y) {
    String filename = file + ".png";
    platform = loadImage("backgrounds/" + filename);
    
    this.x=x;
    this.y=y;
 
    this.width = platform.width;
    this.height = platform.height;
  }

  void display(int xshift) {
    if(x+xshift>=0){
      image(platform, this.x-xshift, this.y-this.height);
    }
    else if(x+xshift>12500){
      image(platform, this.x-xshift, this.y-this.height);
    }
    else if(x+xshift<0){
      image(platform, this.x, this.y-this.height);
    }
  }
  
  
  int getWidth() {
    return platform.width;
  } 
  
  int getHeight() {
    return platform.height;
  } 
}
