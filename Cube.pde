import java.util.Map;

class Cube {
  private HashMap<Integer, Cubie> cubies = new HashMap<Integer, Cubie>();
  int[] posI = new int[]{32,16,8,4,2,1};
  int upI,downI,rightI,leftI,frontI,backI;
  char[] posC = new char[]{'u','d','r','l','f','b'};
  char upC,downC,rightC,leftC,frontC,backC;
  int urf,urb,ulb,ulf,drf,drb,dlf,dlb;
  int ur,ub,ul,uf,rf,rb,lf,lb,dr,db,dl,df;
  int size;

  Cube() {
    upI=posI[0];downI=posI[1];rightI=posI[2];leftI=posI[3];frontI=posI[4];backI=posI[5];
    upC=posC[0];downC=posC[1];rightC=posC[2];leftC=posC[3];frontC=posC[4];backC=posC[5];
    urf = upI+rightI+frontI;
    urb = upI+rightI+backI;
    ulb = upI+leftI+backI;
    ulf = upI+leftI+frontI;
    drf = downI+rightI+frontI;
    drb = downI+rightI+backI;
    dlb = downI+leftI+backI;
    dlf = downI+leftI+frontI;
    ur = upI+rightI;
    ub = upI+backI;
    ul = upI+leftI;
    uf = upI+frontI;
    rf = rightI+frontI;
    rb = rightI+backI;
    lf = leftI+frontI;
    lb = leftI+backI;
    dr = downI+rightI;
    db = downI+backI;
    dl = downI+leftI;
    df = downI+frontI;
    reset();
  }
  
  void reset() {
    size = 100;
    setupCubies();
  }

  void scramble() {
    char prev=' ',prevPrev=' ';
    String[] moves = moves();
    for (int i = 0; i < 20; i++) {
      int index = int(random(moves.length));
      if (moves[index].charAt(0) == prev) {
        i--;
        continue;
      }
      if (moves[index].charAt(0) == prevPrev) {
        i--;
        continue;
      }
      prevPrev = prev;
      prev = moves[index].charAt(0);
      turn(moves[index]);
    }
  }

  void turn(String move) {
    char[] chars = move.toCharArray();
    int t = intPosFromChar(chars[0]);
    if (chars.length == 1) { // clock-wise
      turn(t, true);
    } else if (chars[1] == '2') { // clock-wise twice
      turn(t, true);
      turn(t, true);
    } else { // counter-clock-wise
      turn(t, false);
    }
  }

  private void turn(int t, boolean clockwise) {
    int r;
    if (t == posI[0]) {
      r = clockwise ? turnU() : turnUC();
    }
    if (t == posI[1]) {
      r = clockwise ? turnD() : turnDC();
    }
    if (t == posI[2]) {
      r = clockwise ? turnR() : turnRC();
    }
    if (t == posI[3]) {
      r = clockwise ? turnL() : turnLC();
    }
    if (t == posI[4]) {
      r = clockwise ? turnF() : turnFC();
    }
    if (t == posI[5]) {
      r = clockwise ? turnB() : turnBC();
    }
    applyTurn(t, clockwise);
  }

  private void applyTurn(int t, boolean clockwise) {
    String binT = Integer.toBinaryString(t);
    while (binT.length() < 8) {
      binT = '0'+binT;
    }
    int index = binT.indexOf('1');
    for (int k : cubies.keySet()) {
      String binK = Integer.toBinaryString(k);
      while (binK.length() < 8) {
        binK = '0'+binK;
      }
      Cubie cubie = cubies.get(k);
      if (binK.charAt(index) == '1')
        cubie.turn(t,clockwise);
    }
  }
  
  private int turn(int[] corners, int[] edges) {
    Cubie tmp = cubies.get(corners[0]);
    for(int i = 0; i < corners.length-1; i++) {
      cubies.put(corners[i],cubies.get(corners[i+1]));
    }
    cubies.put(corners[corners.length-1],tmp);
    
    tmp = cubies.get(edges[0]);
    for(int i = 0; i < edges.length-1; i++) {
      cubies.put(edges[i],cubies.get(edges[i+1]));
    }
    cubies.put(edges[edges.length-1],tmp);
    return 0;
  }

  private int turnU() {
    return turn(new int[]{urf,urb,ulb,ulf},new int[]{ur,ub,ul,uf});
  }

  private int turnUC() {
    return turn(new int[]{urf,ulf,ulb,urb},new int[]{ur,uf,ul,ub});
  }  

  private int turnD() {
    return turn(new int[]{drf,dlf,dlb,drb},new int[]{dr,df,dl,db});
  }

  private int turnDC() {
    return turn(new int[]{drf,drb,dlb,dlf},new int[]{dr,db,dl,df});
  }

  private int turnR() {
    return turn(new int[]{urf,drf,drb,urb},new int[]{ur,rf,dr,rb});
  }

  private int turnRC() {
    return turn(new int[]{urf,urb,drb,drf},new int[]{ur,rb,dr,rf});
  }

  private int turnL() {
    return turn(new int[]{ulf,ulb,dlb,dlf},new int[]{ul,lb,dl,lf});
  }

  private int turnLC() {
    return turn(new int[]{ulf,dlf,dlb,ulb},new int[]{ul,lf,dl,lb});
  }

  private int turnF() {
    return turn(new int[]{urf,ulf,dlf,drf},new int[]{uf,lf,df,rf});
  }

  private int turnFC() {
    return turn(new int[]{urf,drf,dlf,ulf},new int[]{uf,rf,df,lf});
  }

  private int turnB() {
    return turn(new int[]{urb,drb,dlb,ulb},new int[]{ub,rb,db,lb});
  }

  private int turnBC() {
    return turn(new int[]{urb,ulb,dlb,drb},new int[]{ub,lb,db,rb});
  }

  void show() {
    rotateX(PI/3);
    rotateZ(-PI/3);
    for (int k : cubies.keySet()) {
      if (k == 0)
        continue;
      Cubie cubie = cubies.get(k);
      int x=0, y=0, z=0;
      if (k >= upI) {
        k -= upI;
        z += size;
      }
      if (k >= downI) {
        k -= downI;
        z -= size;
      }
      if (k >= rightI) {
        k -= rightI;
        y += size;
      }
      if (k >= leftI) {
        k -= leftI;
        y -= size;
      }
      if (k >= frontI) {
        k -= frontI;
        x -= size;
      }
      if (k >= backI) {
        k -= backI;
        x += size;
      }
      translate(x, y, z);
      cubie.show();
      translate(-x, -y, -z);
    }
    rotateZ(PI/3);
    rotateX(-PI/3);
  }

  void showC() {
    int[] pos = setupPos();
    for (int k : cubies.keySet()) {
      if (k == 0)
        continue;
      int index = find(pos,k);
      float y = map(index, 0, 26, 30, 780);
      int x=30;
      fill(0, 0, 0);
      Cubie cubie = cubies.get(k);
      if (k >= upI) {
        k -= upI;
        text('u', x, y);
      }
      if (k >= downI) {
        k -= downI;
        text('d', x, y);
      }
      if (k >= rightI) {
        k -= rightI;
        text('r', x+20, y);
      }
      if (k >= leftI) {
        k -= leftI;
        text('l', x+20, y);
      }
      if (k >= frontI) {
        k -= frontI;
        text('f', x+40, y);
      }
      if (k >= backI) {
        k -= backI;
        text('b', x+40, y);
      }
      x+= 60;
      text(" : ", x, y);
      x+=40;
      cubie.showC(x, y);
    }
  }

  private void setupCubies() {
    int[] pos = setupPos();
    for (int i = 0; i < pos.length; i++) {
      int p = pos[i];
      cubies.put(p, new Cubie(p, size,this));
    }
  }

  private int[] setupPos() {
    int i = 0;
    int[] pos = new int[27];
    pos[i++] = urf;
    pos[i++] = uf;
    pos[i++] = ulf;
    pos[i++] = ur;
    pos[i++] = upI;
    pos[i++] = ul;
    pos[i++] = urb;
    pos[i++] = ub;
    pos[i++] = ulb;

    pos[i++] = rf;
    pos[i++] = frontI;
    pos[i++] = lf;
    pos[i++] = rightI;
    pos[i++] = 0;
    pos[i++] = leftI;
    pos[i++] = rb;
    pos[i++] = backI;
    pos[i++] = lb;

    pos[i++] = drf;
    pos[i++] = df;
    pos[i++] = dlf;
    pos[i++] = dr;
    pos[i++] = downI;
    pos[i++] = dl;
    pos[i++] = drb;
    pos[i++] = db;
    pos[i++] = dlb;

    return pos;
  }

  String[] moves() {
    String[] moves = new String[18];
    int i = 0;
    moves[i++] = "u";
    moves[i++] = "u2";
    moves[i++] = "u'";
    moves[i++] = "d";
    moves[i++] = "d2";
    moves[i++] = "d'";
    moves[i++] = "r";
    moves[i++] = "r2";
    moves[i++] = "r'";
    moves[i++] = "l";
    moves[i++] = "l2";
    moves[i++] = "l'";
    moves[i++] = "f";
    moves[i++] = "f2";
    moves[i++] = "f'";
    moves[i++] = "b";
    moves[i++] = "b2";
    moves[i++] = "b'";
    return moves;
  }
  
  private int intPosFromChar(char c) {
    int index = new String(posC).indexOf(c);
    return posI[index];
  }
}
