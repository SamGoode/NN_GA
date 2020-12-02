class Eye {
  PVector pos;
  float angle;
  /*
  Eye(Eye eye) {
    this.pos = new PVector(eye.pos.x, eye.pos.y);
    this.angle = eye.angle;
  }
  */
  Eye(Player owner, float theta) {
    this.pos = owner.pos;
    this.angle = theta;
  }
  
  float getDist() {
    float sightRange = 400;
    float minDist = sightRange;
    
    if(cos(this.angle) == 1) {
      minDist = min(width-this.pos.x, minDist);
    }
    else if(sin(this.angle) == 1 && height-this.pos.y < minDist) {
      minDist = min(height-this.pos.y, minDist);
    }
    else if(cos(this.angle) == -1 && this.pos.x < minDist) {
      minDist = min(this.pos.x, minDist);
    }
    else if(sin(this.angle) == -1 && this.pos.y < minDist) {
      minDist = min(this.pos.y, minDist);
    }
    else if(cos(this.angle) > 0 && sin(this.angle) > 0) {
      float eyeM = (float)Math.tan(this.angle);
      PVector widthIntercept = new PVector(width, eyeM*(width-this.pos.x)+this.pos.y);
      PVector heightIntercept = new PVector(((height-this.pos.y)/eyeM)+this.pos.x, height);
      
      minDist = min(this.pos.dist(widthIntercept), this.pos.dist(heightIntercept), minDist);
    }
    else if(cos(this.angle) < 0 && sin(this.angle) > 0) {
      float eyeM = (float)Math.tan(this.angle);
      PVector xIntercept = new PVector(0, eyeM*(-this.pos.x)+this.pos.y);
      PVector heightIntercept = new PVector(((height-this.pos.y)/eyeM)+this.pos.x, height);
      
      minDist = min(this.pos.dist(xIntercept), this.pos.dist(heightIntercept), minDist);
    }
    else if(cos(this.angle) < 0 && sin(this.angle) < 0) {
      float eyeM = (float)Math.tan(this.angle);
      PVector xIntercept = new PVector(0, eyeM*(-this.pos.x)+this.pos.y);
      PVector yIntercept = new PVector(((-this.pos.y)/eyeM)+this.pos.x, 0);
      
      minDist = min(this.pos.dist(xIntercept), this.pos.dist(yIntercept), minDist);
    }
    else {
      float eyeM = (float)Math.tan(this.angle);
      PVector widthIntercept = new PVector(width, eyeM*(width-this.pos.x)+this.pos.y);
      PVector yIntercept = new PVector(((-this.pos.y)/eyeM)+this.pos.x, 0);
      
      minDist = min(this.pos.dist(widthIntercept), this.pos.dist(yIntercept), minDist);
    }
    
    for(int i = 0;i < balls.length;i++) {
      float x;
      float y;
      
      if(sin(this.angle) == 1) {
        if(balls[i].pos.y < this.pos.y) {
          continue;
        }
        
        x = this.pos.x;
        y = balls[i].pos.y;
      }
      else if(sin(this.angle) == -1) {
        if(balls[i].pos.y > this.pos.y) {
          continue;
        }
        
        x = this.pos.x;
        y = balls[i].pos.y;
      }
      else if(cos(this.angle) == 1) {
        if(balls[i].pos.x < this.pos.x) {
          continue;
        }
        
        x = balls[i].pos.x;
        y = this.pos.y;
      }
      else if(cos(this.angle) == -1) {
        if(balls[i].pos.x > this.pos.x) {
          continue;
        }
        
        x = balls[i].pos.x;
        y = this.pos.y;
      }
      else {
        float eyeM = (float)Math.tan(this.angle);
        float ballM = (float)Math.tan(this.angle+(Math.PI/2));
        
        x = (balls[i].pos.y-this.pos.y+(eyeM*this.pos.x)-(ballM*balls[i].pos.x))/(eyeM-ballM);
        y = (eyeM*(x-this.pos.x))+this.pos.y;
        
        if(cos(this.angle) > 0 && x < this.pos.x) {
          continue;
        }
        else if(cos(this.angle) < 0 && x > this.pos.x) {
          continue;
        }
      }
      
      PVector lineIntersect = new PVector(x, y);
      
      float f = balls[i].pos.dist(lineIntersect);
      float r = balls[i].size/2;
      float g = sqrt(pow(r, 2)-pow(f, 2));
      
      float distance = this.pos.dist(lineIntersect)-g;
      
      if(minDist > distance) {
        minDist = distance;
      }
    }
    return minDist;
  }
  
  void show() {
    PVector lineEnd;
    lineEnd = PVector.fromAngle(this.angle);
    lineEnd.setMag(getDist());
    lineEnd.add(this.pos);
    
    stroke(0);
    line(pos.x, pos.y, lineEnd.x, lineEnd.y);
  }
}
