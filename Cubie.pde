import java.util.Map;

class Cubie {
  Cube cube;
  Integer up, down, right, left, front, back;
  int size;
  int[] posI;
  char[] posC;
  int upI,downI,rightI,leftI,frontI,backI;
  int id;
  PShape group;
  PShape upFace, downFace, rightFace, leftFace, frontFace, backFace;
  boolean inTurn;

  Cubie(int p,int s,Cube cube) {
    this.cube = cube;
    posI = new int[]{32,16,8,4,2,1};
    posC = new char[]{'u','d','r','l','f','b'};
    upI=posI[0];downI=posI[1];rightI=posI[2];leftI=posI[3];frontI=posI[4];backI=posI[5];
    size = s;
    up = 0;
    down = 0;
    right = 0;
    left = 0;
    front = 0;
    back = 0;
    id = p;
    setupFaces(p);
    
    group = createShape(GROUP);
    
    upFace = createShape();
    upFace.beginShape();
    upFace.vertex(-size/2,-size/2,size/2);
    upFace.vertex(-size/2,size/2,size/2);
    upFace.vertex(size/2,size/2,size/2);
    upFace.vertex(size/2,-size/2,size/2);
    upFace.endShape(CLOSE);
    group.addChild(upFace);
    
    downFace = createShape();
    downFace.beginShape();
    downFace.vertex(-size/2,-size/2,-size/2);
    downFace.vertex(-size/2,size/2,-size/2);
    downFace.vertex(size/2,size/2,-size/2);
    downFace.vertex(size/2,-size/2,-size/2);
    downFace.endShape(CLOSE);
    downFace.setFill(getColor('d'));
    group.addChild(downFace);
    
    rightFace = createShape();
    rightFace.beginShape();
    rightFace.vertex(-size/2,size/2,size/2);
    rightFace.vertex(size/2,size/2,size/2);
    rightFace.vertex(size/2,size/2,-size/2);
    rightFace.vertex(-size/2,size/2,-size/2);
    rightFace.endShape(CLOSE);
    rightFace.setFill(getColor('r'));
    group.addChild(rightFace);
    
    leftFace = createShape();
    leftFace.beginShape();
    leftFace.vertex(-size/2,-size/2,size/2);
    leftFace.vertex(size/2,-size/2,size/2);
    leftFace.vertex(size/2,-size/2,-size/2);
    leftFace.vertex(-size/2,-size/2,-size/2);
    leftFace.endShape(CLOSE);
    leftFace.setFill(getColor('l'));
    group.addChild(leftFace);
    
    frontFace = createShape();
    frontFace.beginShape();
    frontFace.vertex(-size/2,-size/2,-size/2);
    frontFace.vertex(-size/2,size/2,-size/2);
    frontFace.vertex(-size/2,size/2,size/2);
    frontFace.vertex(-size/2,-size/2,size/2);
    frontFace.endShape(CLOSE);
    frontFace.setFill(getColor('f'));
    group.addChild(frontFace);
    
    backFace = createShape();
    backFace.beginShape();
    backFace.vertex(size/2,-size/2,-size/2);
    backFace.vertex(size/2,size/2,-size/2);
    backFace.vertex(size/2,size/2,size/2);
    backFace.vertex(size/2,-size/2,size/2);
    backFace.endShape(CLOSE);
    backFace.setFill(getColor('b'));
    group.addChild(backFace);
    
    inTurn = false;
  }

  void turn(int t, boolean clockwise) {
    if (center()) {
      return;
    }
    int tmp;
    if (t == posI[0]) {
      tmp = clockwise ? turnU() : turnUC();
    }
    if (t == posI[1]) {
      tmp = clockwise ? turnD() : turnDC();
    }
    if (t == posI[2]) {
      tmp = clockwise ? turnR() : turnRC();
    }
    if (t == posI[3]) {
      tmp = clockwise ? turnL() : turnLC();
    }
    if (t == posI[4]) {
      tmp = clockwise ? turnF() : turnFC();
    }
    if (t == posI[5]) {
      tmp = clockwise ? turnB() : turnBC();
    }
  }

  int turnU() {
    int tmp = left;
    left = front;
    front = right;
    right = back;
    back = tmp;
    return 0;
  }

  int turnUC() {
    int tmp = left;
    left = back;
    back = right;
    right = front;
    front = tmp;
    return 0;
  }

  int turnD() {
    int tmp = left;
    left = back;
    back = right;
    right = front;
    front = tmp;
    return 0;
  }

  int turnDC() {
    int tmp = left;
    left = front;
    front = right;
    right = back;
    back = tmp;
    return 0;
  }

  int turnR() {
    int tmp = up;
    up = front;
    front = down;
    down = back;
    back = tmp;
    return 0;
  }

  int turnRC() {
    int tmp = up;
    up = back;
    back = down;
    down = front;
    front = tmp;
    return 0;
  }

  int turnL() {
    int tmp = up;
    up = back;
    back = down;
    down = front;
    front = tmp;
    return 0;
  }

  int turnLC() {
    int tmp = up;
    up = front;
    front = down;
    down = back;
    back = tmp;
    return 0;
  }

  int turnF() {
    int tmp = up;
    up = left;
    left = down;
    down = right;
    right = tmp;
    return 0;
  }

  int turnFC() {
    int tmp = up;
    up = right;
    right = down;
    down = left;
    left = tmp;
    return 0;
  }

  int turnB() {
    int tmp = up;
    up = right;
    right = down;
    down = left;
    left = tmp;
    return 0;
  }

  int turnBC() {
    int tmp = up;
    up = left;
    left = down;
    down = right;
    right = tmp;
    return 0;
  }

  boolean center() {
    return (up == 0 && down == 0 && right == 0 && left == 0 && front == 0 && back != 0) ||
      (up == 0 && down == 0 && right == 0 && left == 0 && front != 0 && back == 0) ||
      (up == 0 && down == 0 && right == 0 && left != 0 && front == 0 && back == 0) ||
      (up == 0 && down == 0 && right != 0 && left == 0 && front == 0 && back == 0) ||
      (up == 0 && down != 0 && right == 0 && left == 0 && front == 0 && back == 0) ||
      (up != 0 && down == 0 && right == 0 && left == 0 && front == 0 && back == 0);
  }
  
  void show() {
    inTurn = java.util.Arrays.asList(cube.turning).indexOf(group) > -1;
    showU();
    showD();
    showR();
    showL();
    showF();
    showB();
    shape(group);
  }
  
  private void showU() {
    upFace.setFill(color(up));
    if (inTurn && currentTurn == 'u') {
      int x=0,y=0;
      if (left != 0)
        y=size;
      if (right != 0)
        y=-size;
      if (front != 0)
        x=size;
      if (back != 0)
        x=-size;
      translate(x,y,0);
      rotateZ(rotating-direction*PI/2);
      translate(-x,-y,0);
    }
  }
  
  private void showD() {
    downFace.setFill(color(down));
    if (inTurn && currentTurn == 'd') {
      int x=0,y=0;
      if (left != 0)
        y=size;
      if (right != 0)
        y=-size;
      if (front != 0)
        x=size;
      if (back != 0)
        x=-size;
      translate(x,y,0);
      rotateZ(-rotating+direction*PI/2);
      translate(-x,-y,0);
    }
  }
  
  private void showR() {
    rightFace.setFill(color(right));
    if (inTurn && currentTurn == 'r') {
      int x=0,z=0;
      if (up != 0)
        z=-size;
      if (down != 0)
        z=size;
      if (front != 0)
        x=size;
      if (back != 0)
        x=-size;
      translate(x,0,z);
      rotateY(rotating-direction*PI/2);
      translate(-x,0,-z);
    }
  }
  
  private void showL() {
    leftFace.setFill(color(left));
    if (inTurn && currentTurn == 'l') {
      int x=0,z=0;
      if (up != 0)
        z=-size;
      if (down != 0)
        z=size;
      if (front != 0)
        x=size;
      if (back != 0)
        x=-size;
      translate(x,0,z);
      rotateY(-rotating+direction*PI/2);
      translate(-x,0,-z);
    }
  }
  
  private void showF() {
    frontFace.setFill(color(front));
    if (inTurn && currentTurn == 'f') {
      int y=0,z=0;
      if (up != 0)
        z=-size;
      if (down != 0)
        z=size;
      if (left != 0)
        y=size;
      if (right != 0)
        y=-size;
      translate(0,y,z);
      rotateX(-rotating+direction*PI/2);
      translate(0,-y,-z);
    }
  }
  
  private void showB() {
    backFace.setFill(color(back));
    if (inTurn && currentTurn == 'b') {
      int y=0,z=0;
      if (up != 0)
        z=-size;
      if (down != 0)
        z=size;
      if (left != 0)
        y=size;
      if (right != 0)
        y=-size;
      translate(0,y,z);
      rotateX(rotating-direction*PI/2);
      translate(0,-y,-z);
    }
  }

  void showC(int x, double y) {
    if (up != 0) {
      fill(color(up));
      text('u', (float)x, (float)y);
    }
    if (down != 0) {
      fill(color(down));
      text('d', (float)x, (float)y);
    }
    if (right != 0) {
      fill(color(right));
      text('r', (float)x+20, (float)y);
    }
    if (left != 0) {
      fill(color(left));
      text('l', (float)x+20, (float)y);
    }
    if (front != 0) {
      fill(color(front));
      text('f', (float)x+40, (float)y);
    }
    if (back != 0) {
      fill(color(back));
      text('b', (float)x+40, (float)y);
    }
  }

  private void setupFaces(int p) {
    if (p >= upI) {
      up = getColor('u');
      p -= upI;
    }
    if (p >= downI) {
      down = getColor('d');
      p -= downI;
    }
    if (p >= rightI) {
      right = getColor('r');
      p -= rightI;
    }
    if (p >= leftI) {
      left = getColor('l');
      p -= leftI;
    }
    if (p >= frontI) {
      front = getColor('f');
      p -= frontI;
    }
    if (p >= backI) {
      back = getColor('b');
      p -= backI;
    }
  }

  private color getColor(char c) {
    if (c == 'u')
      return color(255, 255, 255);
    if (c == 'd')
      return color(255, 255, 0);
    if (c == 'r')
      return color(255, 165, 0);
    if (c == 'l')
      return color(255, 0, 0);
    if (c == 'f')
      return color(0, 0, 255);
    else //if (c == 'b')
    return color(0, 255, 0);
  }
}
