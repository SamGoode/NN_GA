class Player {
  PVector pos;
  PVector vel;
  int size;
  color colour;
  Boolean isDead;
  int score;
  int framesStill;
  int framesSameAxis;
  Eye[] eyes;
  NeuralNetwork brain;
  
  Player(int x, int y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    size = 20;
    colour = (0);
    isDead = false;
    score = 0;
    framesStill = 0;
    framesSameAxis = 0;
    eyes = new Eye[8];
    for(int i = 0;i < eyes.length;i++) {
      //Create a first eye to the right and every next eye is 45 degrees clockwise from the previous one.
      eyes[i] = new Eye(this, i*PI/4);
    }
    brain = new NeuralNetwork(this);
  }
  
  void checkBallCollision() {
    for(int i = 0;i < balls.length;i++) {
      if(this.pos.dist(balls[i].pos) <= (balls[i].size/2)+(this.size/2)) {
        this.isDead = true;
      }
    }
  }
  
  void checkBorderCollision() {
    if(this.pos.x < this.size/2) {
      this.isDead = true;
    }
    else if(this.pos.x > width-(this.size/2)) {
      this.isDead = true;
    }
    if(this.pos.y < this.size/2) {
      this.isDead = true;
    }
    else if(this.pos.y > height-(this.size/2)) {
      this.isDead = true;
    }
  }
  
  void update() {
    this.score += 1;
    
    this.vel.setMag(0);
    
    this.brain.update();
    
    if(this.brain.outputNeurons[0] > 0.75) {//keys.getValue(RIGHT)) {
      PVector acc = new PVector();
      acc = PVector.fromAngle(0);
      acc.setMag(5);
      this.vel.add(acc);
    }
    if(this.brain.outputNeurons[1] > 0.75) {//keys.getValue(RIGHT)) {
      PVector acc = new PVector();
      acc = PVector.fromAngle((float)Math.PI/2);
      acc.setMag(5);
      this.vel.add(acc);
    }
    if(this.brain.outputNeurons[2] > 0.75) {//keys.getValue(RIGHT)) {
      PVector acc = new PVector();
      acc = PVector.fromAngle((float)Math.PI);
      acc.setMag(5);
      this.vel.add(acc);
    }
    if(this.brain.outputNeurons[3] > 0.75) {//keys.getValue(RIGHT)) {
      PVector acc = new PVector();
      acc = PVector.fromAngle((float)Math.PI*3/2);
      acc.setMag(5);
      this.vel.add(acc);
    }
    
    this.vel.limit(5);
    this.pos.add(this.vel);
    
    if(this.vel.mag() < 1) {
      framesStill++;
    }
    else {
      framesStill = 0;
    }
    
    if(abs(this.vel.x) < 1 || abs(this.vel.y) < 1) {
      framesSameAxis++;
    }
    else {
      framesSameAxis = 0;
    }
    
    this.checkBallCollision();
    this.checkBorderCollision();
  }
  
  void show() {
    stroke(this.colour);
    fill(this.colour);
    if(this.isDead) {
      stroke(255, 0, 0);
      fill(255, 0, 0);
    }
    ellipse(pos.x, pos.y, size, size);
    
    for(int i = 0;i < eyes.length;i++) {
      //this.eyes[i].show();
    }
    
    //this.brain.show();
  }
}
