class Bossbullet {
  double x, y, xv, yv;
  int time;
  
  Bossbullet(int x, int y, double xv, double yv, int time) {
    this.time = time;
    this.x = x;
    this.y = y;
    this.xv = xv;
    this.yv = yv;
  }
  
  void update() {
    this.time-=1;
      if(this.time>=0){
      this.xv=this.xv*0.9;
      this.yv=this.yv*0.9;
      }
    this.x += this.xv;
    this.y += this.yv;
  }
  
  void render() {
    fill(255,0,0);
    noStroke();
    ellipse((float) this.x, (float) this.y, 10, 10);
   }
  
  boolean isOffScreen(int width, int height) {
    return (this.x < 0 || this.x > width || this.y < 0 || this.y > height);
  }
}
