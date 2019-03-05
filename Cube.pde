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
  PShape[] turning;
  boolean isTurning;

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
    resetTurning();
  }
  
  void reset() {
    size = 100;
    setupCubies();
  }
  
  void resetTurning() {
    isTurning = false;
    currentTurn = ' ';
    turning = new PShape[9];
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
    resetTurning();
  }

  void turn(String move) {
    char[] chars = move.toCharArray();
    int t = intPosFromChar(chars[0]);
    currentTurn = chars[0];
    if (chars.length == 1) { // clock-wise
      direction = 1;
      turn(t, true);
    } else if (chars[1] == '2') { // clock-wise twice
      direction = 1;
      turn(t, true);
      turn(t, true);
    } else { // counter-clock-wise
      direction = -1;
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
  
  private void showRotate(int[] corners, int[] edges,int center) {
    isTurning = true;
    for(int i = 0; i < corners.length; i++) {
      turning[i] = cubies.get(corners[i]).group;
    }
    for(int i = 0; i < edges.length; i++) {
      turning[i+4] = cubies.get(edges[i]).group;
    }
    turning[8] = cubies.get(center).group;
  }

  private int turnU() {
    int[] corners = new int[]{urf,urb,ulb,ulf};
    int[] edges = new int[]{ur,ub,ul,uf};
    showRotate(corners,edges,upI);
    return turn(corners,edges);
  }

  private int turnUC() {
    int[] corners = new int[]{urf,ulf,ulb,urb};
    int[] edges = new int[]{ur,uf,ul,ub};
    showRotate(corners,edges,upI);
    return turn(corners,edges);
  }  

  private int turnD() {
    int[] corners = new int[]{drf,dlf,dlb,drb};
    int[] edges = new int[]{dr,df,dl,db};
    showRotate(corners,edges,downI);
    return turn(corners,edges);
  }

  private int turnDC() {
    int[] corners = new int[]{drf,drb,dlb,dlf};
    int[] edges = new int[]{dr,db,dl,df};
    showRotate(corners,edges,downI);
    return turn(corners,edges);
  }

  private int turnR() {
    int[] corners = new int[]{urf,drf,drb,urb};
    int[] edges = new int[]{ur,rf,dr,rb};
    showRotate(corners,edges,rightI);
    return turn(corners,edges);
  }

  private int turnRC() {
    int[] corners = new int[]{urf,urb,drb,drf};
    int[] edges = new int[]{ur,rb,dr,rf};
    showRotate(corners,edges,rightI);
    return turn(corners,edges);
  }

  private int turnL() {
    int[] corners = new int[]{ulf,ulb,dlb,dlf};
    int[] edges = new int[]{ul,lb,dl,lf};
    showRotate(corners,edges,leftI);
    return turn(corners,edges);
  }

  private int turnLC() {
    int[] corners = new int[]{ulf,dlf,dlb,ulb};
    int[] edges = new int[]{ul,lf,dl,lb};
    showRotate(corners,edges,leftI);
    return turn(corners,edges);
  }

  private int turnF() {
    int[] corners = new int[]{urf,ulf,dlf,drf};
    int[] edges = new int[]{uf,lf,df,rf};
    showRotate(corners,edges,frontI);
    return turn(corners,edges);
  }

  private int turnFC() {
    int[] corners = new int[]{urf,drf,dlf,ulf};
    int[] edges = new int[]{uf,rf,df,lf};
    showRotate(corners,edges,frontI);
    return turn(corners,edges);
  }

  private int turnB() {
    int[] corners = new int[]{urb,drb,dlb,ulb};
    int[] edges = new int[]{ub,rb,db,lb};
    showRotate(corners,edges,backI);
    return turn(corners,edges);
  }

  private int turnBC() {
    int[] corners = new int[]{urb,ulb,dlb,drb};
    int[] edges = new int[]{ub,lb,db,rb};
    showRotate(corners,edges,backI);
    return turn(corners,edges);
  }

  void show() {
    for (int k : cubies.keySet()) {
      if (k == 0)
        continue;
      pushMatrix();
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
      popMatrix();
    }
  }

  void showC() {
    int[] pos = setupPos();
    for (int k : cubies.keySet()) {
      if (k == 0)
        continue;
      int index = find(pos,k);
      double y = map(index, 0, 26, 30, 780);
      int x=30;
      fill(0, 0, 0);
      Cubie cubie = cubies.get(k);
      if (k >= upI) {
        k -= upI;
        text('u', (float)x, (float)y);
      }
      if (k >= downI) {
        k -= downI;
        text('d', (float)x, (float)y);
      }
      if (k >= rightI) {
        k -= rightI;
        text('r', (float)x+20, (float)y);
      }
      if (k >= leftI) {
        k -= leftI;
        text('l', (float)x+20, (float)y);
      }
      if (k >= frontI) {
        k -= frontI;
        text('f', (float)x+40, (float)y);
      }
      if (k >= backI) {
        k -= backI;
        text('b', (float)x+40, (float)y);
      }
      x+= 60;
      text(" : ", (float)x, (float)y);
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
