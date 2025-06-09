class GameManager {
    UI ui;
    Illinois illinois;
    Vetaal vetaal;
    Database database;
    Level1 level1;
    Level2 level2;
    Level3 level3;
    Level4 level4;
    Level5 level5;
    int gameState = 0; // Game state initialized to 0 for the main menu
    int resetStartTime = -1; // Timer for reset to Level 1

    GameManager() {
        illinois = new Illinois();
        vetaal = new Vetaal();
        database = new Database();
        level1 = new Level1(this);
        level2 = new Level2(this);
        level3 = new Level3(this);
        level4 = new Level4(this);
        level5 = new Level5(this);
    }

    void setUI(UI ui) {
        this.ui = ui;
    }

    void startGame() {
        startLevel1(); // Start at Level 1 directly when the game starts
    }

    void startNextLevel() {
        gameState++; // Increment the game state to move to the next level
        switch (gameState) {
            case 2:
                startLevel2();
                break;
            case 3:
                startLevel3();
                break;
            case 4:
                startLevel4();
                break;
            case 5:
                startLevel5();
                break;
            case 6:
                println("Congratulations! You've completed the game.");
                gameState = 0; // Reset to the main menu or handle game completion
                break;
        }
    }

    void startLevel1() {
        gameState = 1; // Set game state to 1 for Level 1
        illinois.reset();
        vetaal.reset();
        level1.dialogueBox.setMessage("In a sea of blue, the truth hides in the dark."); // Reset Level 1 message
        level1.loadLevel(1);
    }

    void startLevel2() {
        gameState = 2;
        illinois.reset();
        vetaal.reset();
        level2.dialogueBox.setMessage("Four guardians stand at watch, three of earth and one of moonlight. \nWho holds the key to night's secrets?");
        level2.loadLevel(2);
    }

    void startLevel3() {
        gameState = 3;
        illinois.reset();
        vetaal.reset();
        level3.dialogueBox.setMessage("Thorns and wings\nI spy with my little eye, a chest with a bird and others with cacti,\nbut only one will have the means to make you fly.");
        level3.loadLevel(3);
    }

    void startLevel4() {
        gameState = 4;
        illinois.reset();
        vetaal.reset();
        level4.dialogueBox.setMessage("Garbage or gold\nOne hides the treasure, the rest hold mold.\nLook past the surface, don't be deceived and you will find the gold.");
        level4.loadLevel(4);
    }

    void startLevel5() {
        gameState = 5;
        illinois.reset();
        vetaal.reset();
        level5.dialogueBox.setMessage("Congratulations! You can claim your treasure!");
        level5.loadLevel(5);
    }

    void resetToLevel1() {
        gameState = 1;
        illinois.reset();
        vetaal.reset();
        level1.dialogueBox.setMessage("In a sea of blue, the truth hides in the dark.");
        level1.loadLevel(1);
    }

    void resetToLevel1WithDelay() {
        resetStartTime = millis(); // Start the reset timer
    }
    
    // Ensure any end of game resets properly hide or reset game elements
    void resetGame() {
        gameState = 0; // Reset game state to the main menu
        illinois.reset();
        vetaal.reset();
    }
    
    // Call this method when the game ends or when resetting to the main menu
    void endGame() {
        resetGame(); 
    }

    void update() {
        // Check for reset timer
        if (resetStartTime > 0) {
            int elapsedTime = millis() - resetStartTime;
            if (elapsedTime >= 3000) { // Wait for 3 seconds
                resetStartTime = -1; // Reset the timer
                resetToLevel1(); // Reset to Level 1
            }
        }

        // Update the current game state
        switch (gameState) {
            case 0:
                // Main menu logic (if any)
                break;
            case 1:
                level1.update();
                break;
            case 2:
                level2.update();
                break;
            case 3:
                level3.update();
                break;
            case 4:
                level4.update();
                break;
            case 5:
                level5.update();
                break;
        }
        illinois.update();
        vetaal.update();
    }

    void display() {
        switch (gameState) {
            case 0:
                ui.displayMainMenu(); 
                break;
            case 1:
                level1.displayLevel();
                illinois.display();
                vetaal.display();
                break;
            case 2:
                level2.displayLevel();
                illinois.display();
                vetaal.display();
                break;
            case 3:
                level3.displayLevel();
                illinois.display();
                vetaal.display();
                break;
            case 4:
                level4.displayLevel();
                illinois.display();
                vetaal.display();
                break;
            case 5:
                level5.displayLevel();
                illinois.display();
                vetaal.display();
                break;
        }
    }

    void keyPressed() {
        if (gameState >= 1 && gameState <= 5) {
            illinois.keyPressed();
        }
    }

    void mousePressed() {
        switch (gameState) {
            case 0:
                ui.mousePressed();
                break;
            case 1:
                level1.mousePressed();
                break;
            case 2:
                level2.mousePressed();
                break;
            case 3:
                level3.mousePressed();
                break;
            case 4:
                level4.mousePressed();
                break;
            case 5:
                level5.mousePressed();
                break;
        }
    }

    void quitGame() {
        exit();
    }
}
