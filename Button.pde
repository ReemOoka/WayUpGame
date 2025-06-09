class Button {
  float x, y;
  float w, h;
  PImage img;

  Button(float x, float y, float w, float h, PImage img) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = img;
  }

  void display() {
    image(img, x, y, w, h);
  }

  // Check if mouse is over and Illinois is centered
  boolean isClickable(float illinoisX) {
    float doorCenter = x + w / 2; // Center of the door
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h &&
           abs(illinoisX - doorCenter) <= w / 4; // Check if Illinois is within a quarter-width of the door center
  }
}
