class Level3 extends Database {
    PImage birdChestImage, cactusChestImage; // Images for the chests
    Button[] chests; // Array of chests
    boolean mainChestUnlocked = false; // Tracks if the correct chest is clicked
    int birdChestIndex; // Index of the bird chest (correct choice)
    int delayStartTime = -1; // Timer for transition delay
    GameManager gameManager; // Reference to GameManager

    Level3(GameManager gameManager) {
        this.gameManager = gameManager;
        dialogueBox = new DialogueBox("Thorns and wings\n" +
                                      "I spy with my little eye, a chest with a bird and others with cacti,\n" +
                                      "but only one will have the means to make you fly.");
        chests = new Button[5]; // Initialize the chests array
        initializeChests(); // Set up the chests
    }

    void initializeChests() {
        int chestY = height - 140 - 30;
        int chestWidth = 100;
        int chestHeight = 100;
        int startX = width / 2 - (5 * chestWidth + 4 * 10) / 2; // Center the chests

        // Load images for the chests
        birdChestImage = loadImage("level3/birdchest.png");
        cactusChestImage = loadImage("level3/cactuschest.png");

        if (birdChestImage == null || cactusChestImage == null) {
            println("Error loading chest images.");
            return;
        }

        // Generate x-positions for the chests
        int[] xPositions = new int[5];
        for (int i = 0; i < 5; i++) {
            xPositions[i] = startX + i * (chestWidth + 10);
        }

        // Randomly assign one chest as the bird chest
        birdChestIndex = int(random(5));

        // Initialize the chests with positions and respective images
        for (int i = 0; i < 5; i++) {
            PImage chestImage = (i == birdChestIndex) ? birdChestImage : cactusChestImage;
            chests[i] = new Button(xPositions[i], chestY, chestWidth, chestHeight, chestImage);
        }
    }

    void update() {
        if (mainChestUnlocked && delayStartTime > 0) {
            int elapsedTime = millis() - delayStartTime;
            if (elapsedTime >= 3000) { // Wait for 3 seconds
                gameManager.startNextLevel(); // Transition to the next level
                delayStartTime = -1; // Reset the timer to prevent re-triggering
            }
        }
    }

    @Override
    void displayLevel() {
        // Display the shared background, assets, and dialogue box
        super.displayLevel();
        displayChests(); // Display the chests
    }

    void displayChests() {
        for (Button chest : chests) {
            if (chest != null) {
                chest.display();
            }
        }
    }

    void mousePressed() {
        float illinoisX = gameManager.illinois.getX(); // Get Illinois's position
        for (int i = 0; i < chests.length; i++) {
            if (chests[i].isClickable(illinoisX)) {
                if (i == birdChestIndex) { // Correct chest selected
                    mainChestUnlocked = true;
                    dialogueBox.setMessage("Congratulations! You've found the wings to fly. Proceed to the next challenge!");
                    delayStartTime = millis(); // Start the delay timer for the transition
                } else { // Wrong chest selected
                    dialogueBox.setMessage("Ouch! Those thorns won't help you fly. Returning to Level 1...");
                    gameManager.resetToLevel1WithDelay(); // Trigger reset with delay
                }
            }
        }
    }
}
