
class WayUpGame {
  GameManager gameManager;
  UI ui;

  WayUpGame() {
    gameManager = new GameManager();
    ui = new UI(gameManager);
    gameManager.setUI(ui);
  }

  void update() {
    gameManager.update();
  }

  void display() {
    gameManager.display();
  }

  void keyPressed() {
    gameManager.keyPressed();
  }

  void mousePressed() {
    gameManager.mousePressed();
  }
}
