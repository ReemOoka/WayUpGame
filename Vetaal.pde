class Vetaal {
  float x, y;
  PImage sprite;
  float verticalOffset = 0;
  float spriteWidth = 100;  // Default width
  float spriteHeight = 100; // Default height

  Vetaal() {
    sprite = loadImage("vetaal.png");
    if (sprite == null) {
      println("Error: 'idlevetaal.jpeg' not found.");
    }
    reset();
  }

  void reset() {
    x = width - 150
    ;
    y = 50 + verticalOffset;
  }

  void update() {
    // Continuous updates (if needed)
  }

  void display() {
    if (sprite != null) {
      image(sprite, x, y, spriteWidth, spriteHeight);
    }
  }

  void setVerticalPosition(float offset) {
    verticalOffset = offset;
    reset();
  }

  // Method to set sprite size
  void setSpriteSize(float width, float height) {
    spriteWidth = width;
    spriteHeight = height;
  }
}
