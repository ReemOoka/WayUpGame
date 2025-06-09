class Illinois {
  float x, y;
  PImage sprite;
  float verticalOffset = 0;
  float spriteWidth = 50;
  float spriteHeight = 100;

  Illinois() {
    sprite = loadImage("illinois.png");
    if (sprite == null) {
      println("Error: 'illinois.png' not found.");
    }
    reset();
  }

  void reset() {
    x = 0;
    y = height - 140 + verticalOffset;
  }

  void update() {
    // Any update logic goes here
  }

  void display() {
    if (sprite != null) {
      image(sprite, x, y, spriteWidth, spriteHeight);
    }
  }

  void keyPressed() {
    if (keyCode == LEFT) {
      x -= 10;
      if (x < 0) x = 0;
    } else if (keyCode == RIGHT) {
      x += 10;
      if (x > width - spriteWidth) x = width - spriteWidth;
    }
  }

  void setVerticalPosition(float offset) {
    verticalOffset = offset;
    y = height - 140 + verticalOffset;
  }

  void setSpriteSize(float width, float height) {
    spriteWidth = width;
    spriteHeight = height;
  }
  
  float getX() {
    return x;
  }
}
