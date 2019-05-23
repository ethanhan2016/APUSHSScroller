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
    for(int a=0; a<platnumber; a++){
      if(player.y <= parray[a].y && player.x >= parray[a].x-player.xshift && player.x <= parray[a].x-player.xshift+parray[a].width){
        System.out.println("notok");
        return(parray[a].y);
      }  
    }
    System.out.println("ok");
    return(455);
  }  

  void render(int x, int y, int xshift, Background background) {
    background.display(x, y, xshift);
    for(int j=0; j<platnumber; j++){
      parray[j].display(player.xshift);
    }
  }
  
}
