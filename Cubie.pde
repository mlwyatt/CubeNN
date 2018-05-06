import java.util.Map;

class Cubie {
  Integer up, down, right, left, front, back;
  int size;

  Cubie(String str,int s) {
    size = s;
    up = 0;
    down = 0;
    right = 0;
    left = 0;
    front = 0;
    back = 0;
    setupFaces(str);
  }

  void turn(char t, boolean clockwise) {
    if (center()) {
      return;
    }
    int tmp;
    if (t == 'u') {
      tmp = clockwise ? turnU() : turnUC();
    }
    if (t == 'd') {
      tmp = clockwise ? turnD() : turnDC();
    }
    if (t == 'r') {
      tmp = clockwise ? turnR() : turnRC();
    }
    if (t == 'l') {
      tmp = clockwise ? turnL() : turnLC();
    }
    if (t == 'f') {
      tmp = clockwise ? turnF() : turnFC();
    }
    if (t == 'b') {
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
    showU();
    showD();
    showR();
    showL();
    showF();
    showB();
  }
  
  private void showU() {
    pushMatrix();
    translate(0,0,size/2);
    fill(color(up));
    rect(0,0,size,size);
    popMatrix();
  }
  
  private void showD() {
    pushMatrix();
    translate(0,0,-size/2);
    fill(color(down));
    rect(0,0,size,size);
    popMatrix();
  }
  
  private void showR() {
    pushMatrix();
    translate(0,size/2,0);
    rotateX(PI/2);
    fill(color(right));
    rect(0,0,size,size);
    popMatrix();
  }
  
  private void showL() {
    pushMatrix();
    translate(0,-size/2,0);
    rotateX(PI/2);
    fill(color(left));
    rect(0,0,size,size);
    popMatrix();
  }
  
  private void showF() {
    pushMatrix();
    translate(-size/2,0,0);
    rotateX(PI/2);
    rotateY(PI/2);
    fill(color(front));
    rect(0,0,size,size);
    popMatrix();
  }
  
  private void showB() {
    pushMatrix();
    translate(size/2,0,0);
    rotateX(PI/2);
    rotateY(PI/2);
    fill(color(back));
    rect(0,0,size,size);
    popMatrix();
  }

  void showC(int x, float y) {
    if (up != 0) {
      fill(color(up));
      text('u', x, y);
    }
    if (down != 0) {
      fill(color(down));
      text('d', x, y);
    }
    if (right != 0) {
      fill(color(right));
      text('r', x+20, y);
    }
    if (left != 0) {
      fill(color(left));
      text('l', x+20, y);
    }
    if (front != 0) {
      fill(color(front));
      text('f', x+40, y);
    }
    if (back != 0) {
      fill(color(back));
      text('b', x+40, y);
    }
  }

  private void setupFaces(String str) {
    for (char c : str.toCharArray()) {
      if (c == 'u')
        up = getColor(c);
      if (c == 'd')
        down = getColor(c);
      if (c == 'r')
        right = getColor(c);
      if (c == 'l')
        left = getColor(c);
      if (c == 'f')
        front = getColor(c);
      if (c == 'b')
        back = getColor(c);
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
