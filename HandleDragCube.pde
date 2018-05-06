public class HandleDragCube implements PeasyDragHandler {
  PeasyDragHandler original;
  
  HandleDragCube(PeasyDragHandler original) {
    this.original = original;
  }
  
  public void handleDrag(double dx,double dy) {
    if (!pause) {
        original.handleDrag(dx,dy);
      }
  }
}
