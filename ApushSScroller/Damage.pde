class Damage{
  Damage(){
  }
  
  void PlayertoMob(Player player, Enemy enemy, Stage stage, int index){
    enemy.health -= stage.bullets.get(index).damage;
  }
  
  void MobtoPlayer(Player player, Enemy enemy) {
    player.health -= enemy.damage;
  }
  
  void PlayertoBoss(Player player, Boss boss, Stage stage, int index){
    boss.health -= stage.bullets.get(index).damage;
  }
  
  void BosstoPlayer(Player player, Boss boss, int index){
    player.health -= boss.bulletdmg;
  }
}
