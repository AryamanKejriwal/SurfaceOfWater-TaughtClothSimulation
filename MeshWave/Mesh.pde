class Mesh {
  
  Particle[][] vertices;
  float spacing;
  
  Mesh(int h, int w) {
    vertices = new Particle[h][w];
    
    float H = SIZE/h;
    float W = SIZE/w;
    
    spacing = H < W? H : W;
    //println(height + "  " + width);
    //sping = 1000;
    
    initParticles();
  }
  
  void initParticles() {
    for(int i = 0; i < vertices.length; i++) {
      for(int j = 0; j < vertices[i].length; j++) {
        vertices[i][j] = new Particle(spacing/2 + spacing * i, spacing/2 + spacing * j, 0);
      }
    }
  }
  
  void show() {
    drawStrips();
    
    for(int i = 0; i < vertices.length; i++) {
      for(int j = 0; j < vertices[i].length; j++) {
        //vertices[i][j].show();
        
        neighbourInteraction(i, j);
      }
    }
  }
  
  void drawStrips() {
    
    if(schematic) {
      fill(0, 100, 255);
      stroke(100, 200, 255, 100);
    } else {
      
      shininess(0.6);
      //ambient(0, 100, 255);
      ambient(20, 210, 255);
      //emissive(0, 4, 20);
      emissive(20, 210, 255);
      //specular(20, 200, 255);
      specular(20, 210, 255);
      
      //emissive(255, 0, 0);
      //specular(0, 0, 255);
      
      //noFill();
      noStroke();
    }
    //fill(0, 100, 255);
    
    shininess(0.01);
    ambient(0, 50, 255);
    emissive(0, 5, 26);
    specular(10, 150, 255);
    
    //stroke(100, 200, 255, 100);
    //noStroke();
    for(int i = 0; i < vertices.length - 1; i++) {
      beginShape(TRIANGLE_STRIP);
      for(int j = 0; j < vertices[i].length; j++) {
        Particle v1 = vertices[i][j];
        Particle v2 = vertices[i + 1][j];
        vertex(v1.pos.x, v1.pos.y, v1.pos.z);
        vertex(v2.pos.x, v2.pos.y, v2.pos.z);
      }
      endShape();
    }
  }
  
  void neighbourInteraction(int i, int j) {
    //stroke(255);
    strokeWeight(1);
    
    for(int dx = -1; dx <= 1; dx++) {
      for(int dy = -1; dy <= 1; dy++) {
        //if( (dx == 0 || dy == 0) && !(dx == 0  &&  dy == 0) ) {    //NO DIAGONAL NEIGHBOURS
        if( !(dx == 0  &&  dy == 0) ) {                              //INCLUDES DIAGONAL NEIGHBOURS
          try {
            Particle v1 = vertices[i][j];
            Particle v2 = vertices[i + dx][j + dy];
            //line(v1.pos.x, v1.pos.y, v1.pos.z, v2.pos.x, v2.pos.y, v2.pos.z);
            
            v1.interact(v2);
          }catch(IndexOutOfBoundsException e) {
            
          }
        }
      }
    }
  }
  
  void update() {
    for(int i = 0; i < vertices.length; i++) {
      for(int j = 0; j < vertices[i].length; j++) {
        vertices[i][j].update();
      }
    }
    
    recentreVertices();
  }
  
  void pluckCentre(float h) {
    int i = (vertices.length) / 2;
    int j = (vertices[i].length) / 2;
    
    vertices[i][j].pluck(h);
  }
  
  void agitate(float h, float f) {
    for(int i = 0; i < f; i++) {
      //vertices[random(0, vertices.length + 1)][random(0, vertices[0].length + 1)].pluck(h);
      pluck(h, (int)random(0, vertices.length), (int)random(0, vertices[0].length));
    }
  }
  
  void wave(float h) {
    for (int i = 0; i < vertices.length; i++) {
      pluck(h, i, 0);
    }
  }
  
  void pluckEdge(float h) {
    pluck(h, 0, 0);
  }
  
  void pluckEdges(float range) {
    for(int i = 0; i <= 1; i++) {
      for(int j = 0; j <= 1; j++) {
        pluck(random(-range, range), i * (vertices.length - 1), j * (vertices[i * (vertices.length - 1)].length - 1));
      }
    }
    
  }
  
  void pluck(float h, int i, int j) {
    vertices[i][j].pluck(h);
  }
  
  void recentreVertices() {
    
    float averageZ = 0;
    int counter = 0;
    
    for(int i = 0; i < vertices.length; i++) {
      for(int j = 0; j < vertices[i].length; j++) {
        averageZ += vertices[i][j].pos.z;
        counter++;
      }
    }
    
    averageZ = averageZ/counter;
    
    for(Particle[] v : vertices) {
      for(Particle p : v) {
        p.pos.z -= averageZ;
      }
    }
  }
}
