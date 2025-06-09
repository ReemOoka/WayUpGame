class Level2 extends Database {
    PImage shieldImage, silverShieldImage; // Images for the shields
    Button[] doors; // Array of doors (shields in this case)
    boolean mainDoorUnlocked = false; // Tracks if the correct door is clicked
    int blackDoorIndex; // Index of the silver shield (correct choice)
    int delayStartTime = -1; // Timer for transition delay
    GameManager gameManager; // Reference to GameManager

    Level2(GameManager gameManager) {
        this.gameManager = gameManager;
        dialogueBox = new DialogueBox("Four guardians stand at watch, three of earth and one of moonlight. \nWho holds the key to night's secrets?");
        doors = new Button[4]; // Initialize the doors array
        initializeDoors(); // Set up the shields
    }

    void initializeDoors() {
        int doorY = height - 260 - 30; 
        int doorWidth = 100;
        int doorHeight = 125;
        int startX = width / 2 - (4 * doorWidth + 3 * 10) / 2;

        // Load images for the shields
        shieldImage = loadImage("level2/shield.png");
        silverShieldImage = loadImage("level2/silvershield.png");

        if (shieldImage == null || silverShieldImage == null) {
            println("Error: Shield images not loaded correctly.");
            return;
        }

        // Generate x-positions for the doors
        int[] xPositions = new int[4];
        for (int i = 0; i < 4; i++) {
            xPositions[i] = startX + i * (doorWidth + 10);
        }

        // Randomly assign one door as the silver shield
        blackDoorIndex = int(random(4));

        // Initialize the doors with positions and respective images
        for (int i = 0; i < 4; i++) {
            PImage currentImage = (i == blackDoorIndex) ? silverShieldImage : shieldImage;
            doors[i] = new Button(xPositions[i], doorY, doorWidth, doorHeight, currentImage);
        }
    }

    void update() {
        if (mainDoorUnlocked && delayStartTime > 0) {
            int elapsedTime = millis() - delayStartTime;
            if (elapsedTime >= 3000) { // Wait for 3 seconds
                gameManager.startNextLevel(); // Transition to the next level
                delayStartTime = -1; // Reset the timer to prevent re-triggering
            }
        }
    }

    @Override
    void displayLevel() {
        super.displayLevel(); // Display the shared background and assets
        displayDoors(); // Display the doors (shields)
    }

    void displayDoors() {
        for (Button door : doors) {
            if (door != null) {
                door.display();
            }
        }
    }

    void mousePressed() {
        float illinoisX = gameManager.illinois.getX(); // Get Illinois's position
        for (int i = 0; i < doors.length; i++) {
            if (doors[i].isClickable(illinoisX)) {
                if (i == blackDoorIndex) { // Correct shield selected
                    mainDoorUnlocked = true;
                    dialogueBox.setMessage("Congratulations, you proceed to Level 3!");
                    delayStartTime = millis(); // Start the delay timer for the transition
                } else { // Wrong shield selected
                    dialogueBox.setMessage("Wrong shield, returning to Level 1...");
                    gameManager.resetToLevel1WithDelay(); // Trigger reset with delay
                }
            }
        }
    }
}
