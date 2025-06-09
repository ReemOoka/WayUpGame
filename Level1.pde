class Level1 extends Database {
    PImage blueDoorImage, blackDoorImage; // Images for doors
    Button[] doors; // Array of door buttons
    boolean mainDoorUnlocked = false; // Tracks if the correct door is clicked
    int blackDoorIndex; // Index of the black (correct) door
    GameManager gameManager; // Reference to GameManager
    int delayStartTime = -1; // Timer for level progression

    Level1(GameManager gameManager) {
        this.gameManager = gameManager; // Assign GameManager reference
        dialogueBox = new DialogueBox("In a sea of blue, the truth hides in the dark."); // Set Level 1 riddle
        doors = new Button[4]; // Four doors, three blue, one black
        initializeDoors(); // Initialize doors
    }

    void initializeDoors() {
        int doorY = height - 260 - 30; 
        int doorWidth = 130;
        int doorHeight = 150;
        int startX = width / 2 - (4 * doorWidth + 3 * 10) / 2; // Center the doors horizontally

        // Load door images
        blueDoorImage = loadImage("level1/bluedoor.png");
        blackDoorImage = loadImage("level1/blackdoor.png");

        // Validate if the images were loaded successfully
        if (blueDoorImage == null) {
            println("Error loading blue door image.");
        }
        if (blackDoorImage == null) {
            println("Error loading black door image.");
        }

        // Generate x-positions for the doors
        int[] xPositions = new int[4];
        for (int i = 0; i < 4; i++) {
            xPositions[i] = startX + i * (doorWidth + 10); // Space doors evenly
        }

        // Randomly assign one door as the black door
        blackDoorIndex = int(random(4));

        // Initialize door buttons with positions and images
        for (int i = 0; i < 4; i++) {
            PImage doorImage = (i == blackDoorIndex) ? blackDoorImage : blueDoorImage;
            doors[i] = new Button(xPositions[i], doorY, doorWidth, doorHeight, doorImage);
        }
    }
    
    @Override
    void update() {
        super.update(); // Handle shared updates, such as reset logic
        if (mainDoorUnlocked && delayStartTime > 0) {
            int elapsedTime = millis() - delayStartTime;
            if (elapsedTime >= 3000) { // 3-second delay before transitioning
                gameManager.startNextLevel();
                delayStartTime = -1; // Reset the timer
            }
        }
    }


    void mousePressed() {
        float illinoisX = gameManager.illinois.getX(); // Get Illinois's current x position
        for (int i = 0; i < doors.length; i++) {
            if (doors[i].isClickable(illinoisX)) {
                if (i == blackDoorIndex) { // Correct door selected
                    mainDoorUnlocked = true;
                    dialogueBox.setMessage("Congratulations, you proceed to Level 2!");
                    delayStartTime = millis(); // Start the delay timer for the transition
                } else { // Wrong door selected
                    dialogueBox.setMessage("Wrong door, resetting to Level 1...");
                    gameManager.resetToLevel1WithDelay(); // Trigger reset with delay
                }
            }
        }
    }

    
    @Override
    void displayLevel() {
        // Display shared background, assets, and dialogue box
        super.displayLevel();

        // Display doors
        for (Button door : doors) {
            if (door != null) {
                door.display();
            }
        }
    }
}
