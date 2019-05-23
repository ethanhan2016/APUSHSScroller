class Damage{
  Damage(){
  }
  
  void PlayertoMob(Player player, Enemy enemy, Stage stage, int index){
    enemy.health -= stage.bullets.get(index).damage;
  }
  
  void MobtoPlayer(Player player, Enemy enemy) {
    
  }
}
