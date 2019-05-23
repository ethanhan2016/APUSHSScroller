Platform platform;
import java.util.Random;

class Stage {
  Platform[] parray;
  int platnumber;
  Random rnd = new Random();
  
  Stage(int platnumber) {
    this.platnumber = platnumber;
    parray = new Platform[platnumber];
    for(int i=0; i<platnumber; i++){
      parray[i] = new Platform("ssplatforms", rnd.nextInt(16500), rnd.nextInt(300)+150);
    }  
  }
  
  int checkPCollision(Player player){
    int maxY = 455;
    for(int a=0; a<platnumber; a++){
      if(player.y <= parray[a].y && player.x >= parray[a].x-player.xshift-player.width && player.x <= parray[a].x-player.xshift+parray[a].width){
        //System.out.println("notok");
        //return(parray[a].y);
        maxY = (parray[a].y < maxY) ? parray[a].y : maxY;
      }  
    }
    System.out.println("ok");
    return(maxY);
  }  

  void render(int x, int y, int xshift, Background background) {
    background.display(x, y, xshift);
    for(int j=0; j<platnumber; j++){
      parray[j].display(player.xshift);
    }
  }
  
}
