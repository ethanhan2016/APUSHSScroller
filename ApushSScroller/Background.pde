class Background {
  PImage s1background;
  PImage s2background;
  int  width, height, displaywidth, displayheight;
  boolean stage1clear=false;;
  boolean stage2clear=false;;
  boolean first=false;
  boolean other = true;
  boolean end = false;
  int gstate = 0;
  
  Background(String file) {
    String filename = file + ".png";
    s1background = loadImage("backgrounds/" + filename);
    s2background = loadImage("backgrounds/bossapush.png");
    this.width = s1background.width;
    this.height = s1background.height;
    stage1clear=false;
  }

  void display(int x, int y, int xshift, Player player) {
    println(x+xshift);
    if(player.health<=0){
      background(255);
      fill(0);
      textAlign(CENTER);
      text("Game Over.", 450,100);
      text("Press R to try again.", 450, 200);
    }
    else if((x+xshift>=7700 && !stage1clear && other && gstate==0) || (end == true && !stage1clear && other)){
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
      if(player.x>=800){
        stage1clear=true;
        end = false;
        first = true;
      }
    }
    else if(stage1clear && first && !end && other && gstate==0){
      player.end=false;
      player.xshift = 8600;
      xshift = 8600;
      first=false;
      player.x=100;
      other = false;
      image(s1background.get(x+xshift, y, 900, 500), 0, 0);
    }
    else if(gstate==0 && (x+xshift>=11600 && !stage2clear) || end==true){
      image(s1background.get(11600, y, 900, 500), 0, 0);
      player.end=true;
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
      if(player.x>=800){
        stage2clear=true;
        end = false;
        first = true;
      }
      stage1clear=false;
    }
    else if(stage2clear && first && !end && gstate==0){
      player.end=true;
      player.xshift = 8600;
      xshift = 8600;
      first=false;
      player.x=100;
      image(s2background, 0, 0);
      gstate=1;
    }
    else if(gstate==1){
      player.end=true;
      image(s2background, 0, 0);
      if(player.xv==7){
        player.xshift-=7;
      }
      if(player.xv==-7){
        player.xshift+=7;
      }
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
