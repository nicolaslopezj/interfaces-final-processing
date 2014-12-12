import processing.serial.*;

Serial puerto;
Game game;
Arduino arduino;
Interface inter;
boolean gameError = false;
String typing = "";
String saved = "";

void setup() {
  size(1000, 500);
  arduino = new Arduino();
  game = new Game();
  game.arduino = arduino;
  inter = new Interface();
  inter.arduino = arduino;
  inter.game = game;
  connectArduino();
}

void draw() {
  background(0);
  inter.draw();
  
  if (gameError) {
    fill(255, 0, 0);
    textSize(20);
    textAlign(CENTER, BOTTOM);
    text("Not Found", 500, 490); 
  } else {
    fill(200);
    textSize(20);
    textAlign(CENTER, BOTTOM);
    text(typing, 500, 490);
  }
}

void connectArduino() {
  println(Serial.list());
  print("Connecting to: ");
  int index = 2;
  println(Serial.list()[index]);
  puerto = new Serial(this, Serial.list()[index], 9600);
  puerto.bufferUntil('\n');
  arduino.port = puerto;
}

void serialEvent(Serial puerto)
{
  String message = puerto.readStringUntil('\n');
  if (message != null) {
    println(message);
    arduino.setMessage(message);
  }
}

void keyPressed() {
  // If the return key is pressed, save the String and clear it
  if (key == '\n' ) {
    saved = typing;
    println("New game code: " + saved);
    gameError = !game.setCode(saved);
    if (!gameError) {
      game.startGame();
    }
    typing = "";
  } else {
    gameError = false;
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    typing = typing + key; 
    game.stopGame();
  }
}
