class Button {
  String label;
  double x;    // top left corner x position
  double y;    // top left corner y position
  double w;    // width of button
  double h;    // height of button

  Button(String labelB, double xpos, double ypos, double widthB, double heightB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }

  void show() {
    fill(218);
    stroke(141);
    rectMode(CORNER);
    rect((float)x, (float)y, (float)w, (float)h);
    textAlign(CENTER, CENTER);
    fill(0);
    text(label, (float)(x + (w / 2)), (float)(y + (h / 2)));
  }

  boolean mouseIsOver() {
    return (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h));
  }
}
