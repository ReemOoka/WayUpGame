// ---------------------------------------------------------------------------------------------
// WayUp.pde V1.0
// ---------------------------------------------------------------------------------------------
// Date: 10/28/2024     Comment:                                                       Who
// -------- ----------------------------------------------------------- ------------------------
// 10/28/24            Initial coding----->built basic structure for the game.         GS
// 11/13/24            Level 1 Completed                                               RO
// 11/21/24            Level 2 Completed                                               RO
// 11/22/24            Level 3 and 4 Completed                                         GS
// 11/24/24            Level reset implemented                                         RO
// ---------------------------------------------------------------------------------------------
WayUpGame game;

void setup() {
  size(1000, 800);
  game = new WayUpGame();
}

void draw() {
  game.update();
  game.display();
}

void keyPressed() {
  game.keyPressed();
}

void mousePressed() {
  game.mousePressed();
}
