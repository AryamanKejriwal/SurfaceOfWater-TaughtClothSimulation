class Particle {
  
  PVector pos;
  PVector vel;
  PVector acc;
  
  Particle(float x, float y, float z) {
    pos = new PVector(x, y, z);
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }
  
  void show() {
    noStroke();
    fill(255);
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(3);
    popMatrix();
    
  }
  
  void interact(Particle other) {
    //float x = other.pos.x - pos.x;
    //float y = other.pos.x - pos.x;
    float z = other.pos.z - pos.z;
    PVector force = new PVector(0, 0, z);
    force.mult(RIGIDITY);
    
    acc.add(force);
  }
  
  void update() {
    vel.add(acc);
    pos.add(vel);
    
    vel.mult(FRICTION);
    
    acc.mult(0);
  }
  
  void pluck(float h) {
    //pos.z += h;
    vel.z += h;
  }
  
}
