class Background {
  PImage s1background;
  int  width, height, displaywidth, displayheight;
  boolean stage1clear;
  boolean stage2clear;
  boolean first;
  boolean end = false;
  
  Background(String file) {
    String filename = file + ".png";
    s1background= loadImage("backgrounds/" + filename);
    
    this.width = s1background.width;
    this.height = s1background.height;
    stage1clear=false;
  }

  void display(int x, int y, int xshift, Player player) {
    println(x+xshift);
    if((x+xshift>=7700 && !stage1clear) || end == true){
      player.end=true;
      image(s1background.get(7700, y, 900, 500), 0, 0);
      if(player.xv==7){
        player.xshift-=7;
      }
      if(player.xv==-7){
        player.xshift+=7;
      }
      end = true;
      if(player.x==100){
        end = false;
      }
    }
    else if(stage1clear && first && !end){
      player.end=false;
      player.xshift = 8500;
      xshift= 8500;
      first=false;
      image(s1background.get(x+xshift, y, 900, 500), 0, 0);
    }
    else if(x+xshift>=11600 && !stage2clear && !end){
      player.end=false;
      image(s1background.get(11600, y, 900, 500), 0, 0);
      player.xshift-=7;
    }
    else if(x+xshift>=0 && !end){
      player.end=false;
      image(s1background.get(x+xshift, y, 900, 500), 0, 0);
    }
    else {
      player.end=false;
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
