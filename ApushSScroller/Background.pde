class Background {
  PImage s1background;
  int  width, height, displaywidth, displayheight;
  
  Background(String file) {
    String filename = file + ".png";
    s1background= loadImage("backgrounds/" + filename);
    
    this.width = s1background.width;
    this.height = s1background.height;
  }

  void display(int x, int y, int xshift) {
    if(x+xshift>=0){
      image(s1background.get(x+xshift, y, 900, 500), 0, 0);
    }
    else if(x+xshift>12500){
      image(s1background.get(11600, y, 900, 500), 0, 0);
    }
    else {
      image(s1background.get(0, y , 900, 500), 0, 0);
    }
  }
  
  int getWidth() {
    return s1background.width;
  } 
  
  int getHeight() {
    return s1background.height;
  } 
}
