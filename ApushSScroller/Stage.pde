Platform platform;
Enemy enemyclass;
import java.util.Random;

class Stage {
  Platform[] parray;
  Enemy[] earray;
  int enumber;
  int platnumber;
  Random rnd = new Random();
  
  Stage(int platnumber, int enumber) {
    this.platnumber = platnumber;
    parray = new Platform[platnumber];
    for(int i=0; i<platnumber; i++){
      parray[i] = new Platform("ssplatforms", rnd.nextInt(16500), rnd.nextInt(300)+150);
    }  
    this.enumber = enumber;
    earray = new Enemy[enumber];
    for(int i=0; i<enumber; i++){
      earray[i] = new Enemy(rnd.nextInt(16500), rnd.nextInt(300)+150);
    }  
  }
  
  int checkPCollision(Player player){
    int maxY = 455;
    for(int a=0; a<platnumber; a++){
      if(player.y <= parray[a].y && player.x >= parray[a].x-player.xshift-player.width && player.x <= parray[a].x-player.xshift+parray[a].width){
        maxY = (parray[a].y < maxY) ? parray[a].y : maxY;
      }  
    }
    return(maxY);
  }  
  
  int checkECollision(Enemy enemy){
    int maxY = 455;
    for(int a=0; a<platnumber; a++){
      if(enemy.y <= parray[a].y && enemy.x >= parray[a].x && enemy.x <= parray[a].x+parray[a].width){
        maxY = (parray[a].y < maxY) ? parray[a].y : maxY;
      }  
    }
    return(maxY);
  }  
  
  
  
  void render(int x, int y, int xshift, Background background, Player player) {
    background.display(x, y, xshift, player);
    for(int j=0; j<platnumber; j++){
      parray[j].display(player.xshift);
    }
    for(int i=0; i<enumber; i++){
      earray[i].bottom = this.checkECollision(earray[i]);
      for(int j=0; j<enumber; j++){
        if(earray[i].checkCollisionOther(earray[j],player)==true && !(i==j)){
          earray[i].col=true;
        }
      }
      earray[i].update(player);
      earray[i].render();
    }
  }
  
}
