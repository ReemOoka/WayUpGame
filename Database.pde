class Database {
    PImage levelBackground; // Shared background image
    ArrayList<Asset> levelAssets; // List of assets in the level
    DialogueBox dialogueBox; // Dialogue box for messages

    Database() {
        levelAssets = new ArrayList<>();
        loadSharedBackground(); // Load the shared background image
        dialogueBox = new DialogueBox("Welcome to the level!"); // Default message
    }

    void loadSharedBackground() {
        // Load the shared background image
        levelBackground = loadImage("background.png");
        if (levelBackground == null) {
            println("Error: Background image 'background.png' not found.");
        }
    }

    void loadLevel(int level) {
        // Clear previous assets and load level-specific assets if needed
        levelAssets.clear();
        int assetIndex = 1;
        while (true) {
            PImage assetImage = loadImage("level" + level + "_asset" + assetIndex + ".png");
            if (assetImage == null) {
                println("Info: No more assets found for level " + level + ". Loaded " + (assetIndex - 1) + " assets.");
                break;
            }
            levelAssets.add(new Asset(assetImage, 100 * assetIndex, height - 100));
            assetIndex++;
        }
    }

    void update() {
        // Default update logic, override if needed
    }

    void displayLevel() {
        // Display the shared background image
        if (levelBackground != null) {
            image(levelBackground, 0, 0, width, height);
        } else {
            background(50, 50, 100); // Default background color
        }

        // Display each asset in the level
        for (Asset asset : levelAssets) {
            asset.display();
        }

        // Display the dialogue box
        if (dialogueBox != null) {
            dialogueBox.display();
        }
    }
}
