Platform platform;
Enemy enemyclass;
Boss boss1;
import java.util.Random;
import java.util.ArrayList;
import java.util.List;

class Stage {
  Platform[] parray;
  Platform[] parray1;
  Enemy[] earray;
  int enumber;
  int platnumber;
  int c = 1;
  List<Bullet> bullets = new ArrayList<Bullet>();
  Random rnd = new Random();
  
  Stage(int platnumber, int enumber) {
    this.platnumber = platnumber;
    parray = new Platform[platnumber];
    for(int i=0; i<platnumber; i++){
      parray[i] = new Platform("ssplatforms", rnd.nextInt(12500), rnd.nextInt(300)+120);
    }  
    this.enumber = enumber;
    earray = new Enemy[enumber];
    for(int i=0; i<enumber; i++){
      earray[i] = new Enemy(rnd.nextInt(12500), rnd.nextInt(300)+150);
    }  
    parray1 = new Platform [6];
    for(int i=0; i<6; i++){
      parray1[i]= new Platform("ssplatforms", 400*c-250, 150*((i+1)%3)+50);
      if(i==2){
        c=2;
      }
    }  
    boss1 = new Boss();
  }
  
  void updateBullets() {
    for (int i = 0; i < this.bullets.size(); i++) {
      bullets.get(i).update();
      bullets.get(i).render();
      if(bullets.get(i).isOffScreen(900, 500)) {
        bullets.remove(i);
      }
    }
  }
  
  int checkPCollision(Player player, Platform[] parray0){
    int maxY = 455;
    for(int a=0; a<parray0.length; a++){
      if(player.y <= parray0[a].y && player.x >= parray0[a].x-player.xshift-player.width && player.x <= parray0[a].x-player.xshift+parray0[a].width){
        maxY = (parray0[a].y < maxY) ? parray0[a].y : maxY;
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
    if(background.gstate==0){
      
    player.bottom = this.checkPCollision(player,parray);
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
    else{
      player.bottom =this.checkPCollision(player,parray1);
      boss1.update(player);
      boss1.render(player);
      for(int i=0; i<6; i++){
        parray1[i].display(0);
      }
    }
  }
  
}
