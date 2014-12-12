import processing.serial.*;

Serial puerto;
Game game;
Arduino arduino;
Interface inter;

void setup() {
  size(1000, 500);
  arduino = new Arduino();
  game = new Game("123");
  game.arduino = arduino;
  inter = new Interface();
  inter.arduino = arduino;
  inter.game = game;
  connectArduino();
  game.startGame();
}

void draw() {
  background(0);
  inter.draw();
}

void connectArduino() {
  println(Serial.list());
  print("Connecting to: ");
  int index = 2;
  println(Serial.list()[index]);
  puerto = new Serial(this, Serial.list()[index], 9600);
  puerto.bufferUntil('\n');
}

void serialEvent(Serial puerto)
{
  String message = puerto.readStringUntil('\n');
  if (message != null) {
    arduino.setMessage(message);
  }
}
