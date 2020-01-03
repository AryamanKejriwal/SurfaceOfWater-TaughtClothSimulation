Mesh mesh = new Mesh(107, 107);
float a = 0;

final float FRICTION = 0.994;
final float RIGIDITY = 0.01;

boolean schematic = true;

final int SIZE = 1000;

boolean up = true;

//float a = 0;

void setup() {
  size(1000, 1000, P3D);
  background(0);
  frameRate(60);
  //mesh.wave(random(-10, 10));
  //mesh.pluckEdge(90);
}

void draw() {
  if(!schematic) {
    lights();
  }
  
  translate(width/2, height/2);
  //scale(3);
  rotateX(PI/3);
  //rotateX(a);
  rotateZ(a);
  translate(-width/2, -height/2);
  
  background(0);
  mesh.show();
  //mesh.agitate(random(-1, 1), random(0, 3));
  //mesh.wave(random(-1, 1));
  float turbulance = map(mouseX, 0, width, 0, 20);
  //turbulance = map(sin(frameCount/100.0), -1, 1, 0, 20);
  mesh.pluckEdges(turbulance);
  println(turbulance);
  //println(width);
  mesh.update();
  
  a += 0.005;
  
  println(frameRate);
  //directionalLight(255, 255, 255, 0.5, 0.5, 0.5);
}

void keyPressed() {
  float pluck_height = 50;
  if(up) {
   mesh.pluckCentre(pluck_height);
  } else {
    mesh.pluckCentre(-pluck_height);
  }
  
  up = !up;
}

void mousePressed() {
  schematic = !schematic;
}
