class Level5 extends Database {
    PImage treasureImage;
    Button treasure;
    boolean treasureClaimed = false;
    GameManager gameManager;
    float vetaalY;
    int delayStartTime = -1;

    Level5(GameManager gameManager) {
        super();
        this.gameManager = gameManager;
        dialogueBox = new DialogueBox("Congratulations! You've reached the treasure room. Claim your prize!");
        initializeTreasure();
        vetaalY = -100; // Start Vetaal above the screen
    }

    void initializeTreasure() {
        treasureImage = loadImage("level5/treasure.png");
        if (treasureImage == null) {
            println("Error loading treasure image.");
            return;
        }
        int treasureSize = 150;
        float treasureY = height - treasureSize; 
        treasure = new Button(width / 2 - treasureSize / 2, treasureY, treasureSize, treasureSize, treasureImage);
    }

    void update() {
        super.update();
        if (vetaalY > height && !treasureClaimed) {
            dialogueBox.setMessage("The Vetaal has departed. You are free to claim your treasure!");
        } else if (vetaalY <= height) {
            vetaalY += 2; // Move Vetaal downwards each frame
        }

        if (treasureClaimed && delayStartTime > 0) {
            int elapsedTime = millis() - delayStartTime;
            if (elapsedTime >= 3000) { 
                gameManager.resetGame(); 
                delayStartTime = -1;
            }
        }
    }

    @Override
    void displayLevel() {
        super.displayLevel();
        if (treasure != null) {
            treasure.display();
        }
        displayVetaal();
    }

    void displayVetaal() {
        if (gameManager.vetaal != null) {
            gameManager.vetaal.setVerticalPosition(vetaalY);
            gameManager.vetaal.display();
        }
    }

    void mousePressed() {
        float illinoisX = gameManager.illinois.getX();
        if (treasure != null && treasure.isClickable(illinoisX) && vetaalY > height && !treasureClaimed) {
            treasureClaimed = true;
            dialogueBox.setMessage("Congratulations! You've claimed the treasure and completed the game!");
            delayStartTime = millis(); // Start the delay timer
        }
    }
}
