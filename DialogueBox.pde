class DialogueBox {
  String message;
  float x, y;
  float boxWidth = 650;
  float boxHeight = 100;
  
  DialogueBox(String message) {
    this.message = message;
    x = (width - boxWidth) / 2;
    y = (height - boxHeight) / 2;
  }
  
  void display() {
    // Draw the box
    fill(50, 50, 50, 200); // Dark transparent background
    stroke(255);           // White border
    strokeWeight(2);
    rect(x, y, boxWidth, boxHeight, 10); // Rounded corners
    
    // Display the message
    fill(255); // White text color
    textAlign(CENTER, CENTER);
    textSize(20);
    text(message, x + boxWidth / 2, y + boxHeight / 2);
  }
  
  // Set a new message to display
  void setMessage(String newMessage) {
    message = newMessage;
  }
}
