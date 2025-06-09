class Level4 extends Database {
    PImage goldTrashImage, moldTrashImage; // Images for trash cans
    Button[] trashCans; // Array of trash cans
    boolean treasureFound = false; // Tracks if the correct trash can is clicked
    int goldTrashIndex; // Index of the gold trash can (correct choice)
    GameManager gameManager; // Reference to GameManager
    int delayStartTime = -1; // Timer for delayed transition to the next level

    Level4(GameManager gameManager) {
        this.gameManager = gameManager; // Assign GameManager reference
        dialogueBox = new DialogueBox(
            "Garbage or gold\n" +
            "One hides the treasure, the rest hold mold.\n" +
            "Look past the surface, don't be deceived and you will find the gold."
        );
        trashCans = new Button[6]; // Initialize six trash cans
        initializeTrashCans(); // Set up the trash cans
    }

    void initializeTrashCans() {
        int trashY = height - 140 - 30;
        int trashWidth = 80;
        int trashHeight = 120;
        int startX = width / 2 - (6 * trashWidth + 5 * 10) / 2; // Center the trash cans

        // Load images for the trash cans
        goldTrashImage = loadImage("Level4/goldcan.png");
        moldTrashImage = loadImage("Level4/trashcan.png");

        // Check if images are successfully loaded
        if (goldTrashImage == null) {
            println("Error loading gold trash can image.");
        }
        if (moldTrashImage == null) {
            println("Error loading moldy trash can image.");
        }

        // Generate x-positions for the trash cans
        int[] xPositions = new int[6];
        for (int i = 0; i < 6; i++) {
            xPositions[i] = startX + i * (trashWidth + 10); // Space trash cans evenly
        }

        // Randomly assign one trash can as the gold trash can
        goldTrashIndex = int(random(6));

        // Initialize trash cans with positions and respective images
        for (int i = 0; i < 6; i++) {
            PImage trashImage = (i == goldTrashIndex) ? goldTrashImage : moldTrashImage;
            trashCans[i] = new Button(xPositions[i], trashY, trashWidth, trashHeight, trashImage);
        }
    }

    void update() {
        if (treasureFound && delayStartTime > 0) {
            int elapsedTime = millis() - delayStartTime;
            if (elapsedTime >= 3000) { // Wait for 3 seconds
                gameManager.startNextLevel(); // Transition to the next level
                delayStartTime = -1; // Reset the timer to prevent re-triggering
            }
        }
    }

    @Override
    void displayLevel() {
        // Display shared background, assets, and dialogue box
        super.displayLevel();

        // Display trash cans
        displayTrashCans();
    }

    void displayTrashCans() {
        for (Button trashCan : trashCans) {
            if (trashCan != null) {
                trashCan.display();
            }
        }
    }

    void mousePressed() {
        float illinoisX = gameManager.illinois.getX(); // Get Illinois's current x position
        for (int i = 0; i < trashCans.length; i++) {
            if (trashCans[i].isClickable(illinoisX)) {
                if (i == goldTrashIndex) { // Correct trash can selected
                    treasureFound = true;
                    dialogueBox.setMessage("Congratulations! You've found the gold. Proceed to the next challenge!");
                    delayStartTime = millis(); // Start delay timer for transition
                } else { // Wrong trash can selected
                    dialogueBox.setMessage("Ugh! That's just moldy trash. Keep looking!, Returning to level 1");
                    gameManager.resetToLevel1WithDelay(); 
                }
            }
        }
    }
}
