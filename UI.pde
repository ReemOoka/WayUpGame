class UI {
  GameManager gameManager;
  PImage mainMenuBackground;

  UI(GameManager gameManager) {
    this.gameManager = gameManager;
    
    // Load the main menu background image
    mainMenuBackground = loadImage("wayupmain2.png"); // Ensure this image is in the data folder
    if (mainMenuBackground == null) {
      println("Error: Main menu background image not found.");
    }
  }

  void displayMainMenu() {
    // Display the main menu background if loaded
    if (mainMenuBackground != null) {
      image(mainMenuBackground, 0, 0, width, height);
    } else {
      background(0); // Fallback color if the image is missing
    }

    // Draw Start button
    fill(100);
    rect(width/2 - 100, height/2 - 30, 200, 60);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(24);
    text("Start Game", width/2, height/2);

    // Draw Quit button
    fill(100);
    rect(width/2 - 100, height/2 + 50, 200, 60);
    fill(255);
    text("Quit Game", width/2, height/2 + 80);
  }

  void mousePressed() {
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100) {
      if (mouseY > height/2 - 30 && mouseY < height/2 + 30) {
        gameManager.startLevel1(); // Start directly with Level 1
      } else if (mouseY > height/2 + 50 && mouseY < height/2 + 110) {
        gameManager.quitGame();
      }
    }
  }
}
