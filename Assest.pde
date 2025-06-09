
class Asset {
  PImage sprite;
  float x, y;

  Asset(PImage sprite, float x, float y) {
    this.sprite = sprite;
    if (this.sprite == null) {
      println("Error: Asset image not found.");
    }
    this.x = x;
    this.y = y;
  }

  void display() {
    if (sprite != null) {
      image(sprite, x, y);
    }
  }

  void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }
}
