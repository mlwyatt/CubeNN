import java.util.Map;

class Cube {
  private HashMap<String, Cubie> cubies = new HashMap<String, Cubie>();
  int size;

  Cube() {
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
    if (chars.length == 1) { // clock-wise
      turn(chars[0], true);
    } else if (chars[1] == '2') { // clock-wise twice
      turn(chars[0], true);
      turn(chars[0], true);
    } else { // counter-clock-wise
      turn(chars[0], false);
    }
  }

  private void turn(char t, boolean clockwise) {
    int r;
    if (t == 'u') {
      r = clockwise ? turnU() : turnUC();
    }
    if (t == 'd') {
      r = clockwise ? turnD() : turnDC();
    }
    if (t == 'r') {
      r = clockwise ? turnR() : turnRC();
    }
    if (t == 'l') {
      r = clockwise ? turnL() : turnLC();
    }
    if (t == 'f') {
      r = clockwise ? turnF() : turnFC();
    }
    if (t == 'b') {
      r = clockwise ? turnB() : turnBC();
    }
    applyTurn(t, clockwise);
  }

  private void applyTurn(char t, boolean clockwise) {
    for (String k : cubies.keySet()) {
      if (k.indexOf(t) > -1)
        cubies.get(k).turn(t, clockwise);
    }
  }

  private int turnU() {
    Cubie tmp;
    tmp = cubies.get("urf");
    cubies.put("urf", cubies.get("urb"));
    cubies.put("urb", cubies.get("ulb"));
    cubies.put("ulb", cubies.get("ulf"));
    cubies.put("ulf", tmp);
    tmp = cubies.get("ur");
    cubies.put("ur", cubies.get("ub"));
    cubies.put("ub", cubies.get("ul"));
    cubies.put("ul", cubies.get("uf"));
    cubies.put("uf", tmp);
    return 0;
  }

  private int turnUC() {
    Cubie tmp;
    tmp = cubies.get("urf");
    cubies.put("urf", cubies.get("ulf"));
    cubies.put("ulf", cubies.get("ulb"));
    cubies.put("ulb", cubies.get("urb"));
    cubies.put("urb", tmp);
    tmp = cubies.get("ur");
    cubies.put("ur", cubies.get("uf"));
    cubies.put("uf", cubies.get("ul"));
    cubies.put("ul", cubies.get("ub"));
    cubies.put("ub", tmp);
    return 0;
  }  

  private int turnD() {
    Cubie tmp;
    tmp = cubies.get("drf");
    cubies.put("drf", cubies.get("dlf"));
    cubies.put("dlf", cubies.get("dlb"));
    cubies.put("dlb", cubies.get("drb"));
    cubies.put("drb", tmp);
    tmp = cubies.get("dr");
    cubies.put("dr", cubies.get("df"));
    cubies.put("df", cubies.get("dl"));
    cubies.put("dl", cubies.get("db"));
    cubies.put("db", tmp);
    return 0;
  }

  private int turnDC() {
    Cubie tmp;
    tmp = cubies.get("drf");
    cubies.put("drf", cubies.get("drb"));
    cubies.put("drb", cubies.get("dlb"));
    cubies.put("dlb", cubies.get("dlf"));
    cubies.put("dlf", tmp);
    tmp = cubies.get("dr");
    cubies.put("dr", cubies.get("db"));
    cubies.put("db", cubies.get("dl"));
    cubies.put("dl", cubies.get("df"));
    cubies.put("df", tmp);
    return 0;
  }

  private int turnR() {
    Cubie tmp;
    tmp = cubies.get("urf");
    cubies.put("urf", cubies.get("drf"));
    cubies.put("drf", cubies.get("drb"));
    cubies.put("drb", cubies.get("urb"));
    cubies.put("urb", tmp);
    tmp = cubies.get("ur");
    cubies.put("ur", cubies.get("rf"));
    cubies.put("rf", cubies.get("dr"));
    cubies.put("dr", cubies.get("rb"));
    cubies.put("rb", tmp);
    return 0;
  }

  private int turnRC() {
    Cubie tmp;
    tmp = cubies.get("urf");
    cubies.put("urf", cubies.get("urb"));
    cubies.put("urb", cubies.get("drb"));
    cubies.put("drb", cubies.get("drf"));
    cubies.put("drf", tmp);
    tmp = cubies.get("ur");
    cubies.put("ur", cubies.get("rb"));
    cubies.put("rb", cubies.get("dr"));
    cubies.put("dr", cubies.get("rf"));
    cubies.put("rf", tmp);
    return 0;
  }

  private int turnL() {
    Cubie tmp;
    tmp = cubies.get("ulf");
    cubies.put("ulf", cubies.get("ulb"));
    cubies.put("ulb", cubies.get("dlb"));
    cubies.put("dlb", cubies.get("dlf"));
    cubies.put("dlf", tmp);
    tmp = cubies.get("ul");
    cubies.put("ul", cubies.get("lb"));
    cubies.put("lb", cubies.get("dl"));
    cubies.put("dl", cubies.get("lf"));
    cubies.put("lf", tmp);
    return 0;
  }

  private int turnLC() {
    Cubie tmp;
    tmp = cubies.get("ulf");
    cubies.put("ulf", cubies.get("dlf"));
    cubies.put("dlf", cubies.get("dlb"));
    cubies.put("dlb", cubies.get("ulb"));
    cubies.put("ulb", tmp);
    tmp = cubies.get("ul");
    cubies.put("ul", cubies.get("lf"));
    cubies.put("lf", cubies.get("dl"));
    cubies.put("dl", cubies.get("lb"));
    cubies.put("lb", tmp);
    return 0;
  }

  private int turnF() {
    Cubie tmp;
    tmp = cubies.get("urf");
    cubies.put("urf", cubies.get("ulf"));
    cubies.put("ulf", cubies.get("dlf"));
    cubies.put("dlf", cubies.get("drf"));
    cubies.put("drf", tmp);
    tmp = cubies.get("uf");
    cubies.put("uf", cubies.get("lf"));
    cubies.put("lf", cubies.get("df"));
    cubies.put("df", cubies.get("rf"));
    cubies.put("rf", tmp);
    return 0;
  }

  private int turnFC() {
    Cubie tmp;
    tmp = cubies.get("urf");
    cubies.put("urf", cubies.get("drf"));
    cubies.put("drf", cubies.get("dlf"));
    cubies.put("dlf", cubies.get("ulf"));
    cubies.put("ulf", tmp);
    tmp = cubies.get("uf");
    cubies.put("uf", cubies.get("rf"));
    cubies.put("rf", cubies.get("df"));
    cubies.put("df", cubies.get("lf"));
    cubies.put("lf", tmp);
    return 0;
  }

  private int turnB() {
    Cubie tmp;
    tmp = cubies.get("urb");
    cubies.put("urb", cubies.get("drb"));
    cubies.put("drb", cubies.get("dlb"));
    cubies.put("dlb", cubies.get("ulb"));
    cubies.put("ulb", tmp);
    tmp = cubies.get("ub");
    cubies.put("ub", cubies.get("rb"));
    cubies.put("rb", cubies.get("db"));
    cubies.put("db", cubies.get("lb"));
    cubies.put("lb", tmp);
    return 0;
  }

  private int turnBC() {
    Cubie tmp;
    tmp = cubies.get("urb");
    cubies.put("urb", cubies.get("ulb"));
    cubies.put("ulb", cubies.get("dlb"));
    cubies.put("dlb", cubies.get("drb"));
    cubies.put("drb", tmp);
    tmp = cubies.get("ub");
    cubies.put("ub", cubies.get("lb"));
    cubies.put("lb", cubies.get("db"));
    cubies.put("db", cubies.get("rb"));
    cubies.put("rb", tmp);
    return 0;
  }

  void show() {
    rotateX(PI/3);
    rotateZ(-PI/3);
    for (String k : cubies.keySet()) {
      if (k.equals(""))
        continue;
      int x=0, y=0, z=0;
      if (k.indexOf('u') > -1) {
        z += size;
      }
      if (k.indexOf('d') > -1) {
        z -= size;
      }
      if (k.indexOf('r') > -1) {
        y += size;
      }
      if (k.indexOf('l') > -1) {
        y -= size;
      }
      if (k.indexOf('f') > -1) {
        x -= size;
      }
      if (k.indexOf('b') > -1) {
        x += size;
      }
      translate(x, y, z);
      cubies.get(k).show();
      translate(-x, -y, -z);
    }
    rotateZ(PI/3);
    rotateX(-PI/3);
  }

  void showC() {
    String[] pos = setupPos();
    for (String k : cubies.keySet()) {
      if (k.equals(""))
        continue;
      int index = java.util.Arrays.asList(pos).indexOf(k);
      float y = map(index, 0, 26, 30, 780);
      int x=30;
      fill(0, 0, 0);
      for (char c : k.toCharArray()) {
        int newX = x;
        if (c == 'r' || c == 'l')
          newX += 20;
        if (c == 'f' || c == 'b')
          newX += 40;
        text(c, newX, y);
      }
      x+= 60;
      text(" : ", x, y);
      x+=40;
      cubies.get(k).showC(x, y);
    }
  }

  private void setupCubies() {
    String[] pos = setupPos();
    for (int i = 0; i < pos.length; i++) {
      String p = pos[i];
      cubies.put(p, new Cubie(p, size));
    }
  }

  private String[] setupPos() {
    int i = 0;
    String[] pos = new String[27];
    pos[i++] = "urf";
    pos[i++] = "uf";
    pos[i++] = "ulf";
    pos[i++] = "ur";
    pos[i++] = "u";
    pos[i++] = "ul";
    pos[i++] = "urb";
    pos[i++] = "ub";
    pos[i++] = "ulb";


    pos[i++] = "rf";
    pos[i++] = "f";
    pos[i++] = "lf";
    pos[i++] = "r";
    pos[i++] = "";
    pos[i++] = "l";
    pos[i++] = "rb";
    pos[i++] = "b";
    pos[i++] = "lb";

    pos[i++] = "drf";
    pos[i++] = "df";
    pos[i++] = "dlf";
    pos[i++] = "dr";
    pos[i++] = "d";
    pos[i++] = "dl";
    pos[i++] = "drb";
    pos[i++] = "db";
    pos[i++] = "dlb";

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
}
