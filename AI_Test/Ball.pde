class Ball {
  PVector pos;
  PVector vel;
  float size;
  color Color;
  
  Ball() {
    Color = color(255, 0, 0);
    vel = new PVector();
    vel = PVector.random2D();
    float randMag = (float)(Math.random()*3)+2;
    vel.setMag(randMag);
    
    if(this.vel.heading() > -(Math.PI/4) && this.vel.heading() < (Math.PI/4)) {
      int startY = (int)Math.round(Math.random()*height);
      pos = new PVector(-size/2, startY);
    }
    else if(this.vel.heading() > -(Math.PI*3/4) && this.vel.heading() < -(Math.PI/4)) {
      int startX = (int)Math.round(Math.random()*width);
      pos = new PVector(startX, height+(size/2));
    }
    else if(this.vel.heading() > (Math.PI/4) && this.vel.heading() < (Math.PI*3/4)) {
      int startX = (int)Math.round(Math.random()*width);
      pos = new PVector(startX, -size/2);
    }
    else {
      int startY = (int)Math.round(Math.random()*width);
      pos = new PVector(width+(size/2), startY);
    }
    
    size = (float)(Math.random()*50)+50;
    //vel.setMag(0);
    //pos = new PVector(width/2, height/2-100);
    //size = 100;
  }
  
  void update() {
    this.pos.add(this.vel);
    
    if(this.pos.x > width+5+(this.size/2) || this.pos.x < -5-this.size/2 || this.pos.y > height+5+(this.size/2) || this.pos.y < -5-this.size/2) {
      this.vel = PVector.random2D();
      float randMag = (float)(Math.random()*3)+2;
      this.vel.setMag(randMag);
      
      if(this.vel.heading() > -(Math.PI/4) && this.vel.heading() < (Math.PI/4)) {
        int startY = (int)Math.round(Math.random()*height);
        this.pos.set(-size/2, startY);
      }
      else if(this.vel.heading() > -(Math.PI*3/4) && this.vel.heading() < -(Math.PI/4)) {
        int startX = (int)Math.round(Math.random()*width);
        this.pos.set(startX, height+(size/2));
      }
      else if(this.vel.heading() > (Math.PI/4) && this.vel.heading() < (Math.PI*3/4)) {
        int startX = (int)Math.round(Math.random()*width);
        this.pos.set(startX, -size/2);
      }
      else {
        int startY = (int)Math.round(Math.random()*width);
        this.pos.set(width+(size/2), startY);
      }
      
      this.size = (float)(Math.random()*50)+50;
    }
  }
  
  void show() {
    stroke(Color);
    noFill();
    ellipse(this.pos.x, this.pos.y, size, size);
  }
}
