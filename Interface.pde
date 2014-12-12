class Interface {
  
  Game game;
  Arduino arduino;
  
  Interface() {
    
  }
  
  void draw() {
    // Proximity
    textAlign(LEFT, CENTER);
    if (arduino.proximity1) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    ellipse(30, 30, 15, 15);
    
    textAlign(RIGHT, CENTER);
    if (arduino.proximity2) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    ellipse(970, 30, 15, 15);
    
    if (game.isRunning) {
      // Question
      fill(255);
      textSize(20);
      textAlign(CENTER, CENTER);
      text(game.questionText, 500, 20);
      
      // Game Code
      fill(200);
      textSize(20);
      textAlign(CENTER, BOTTOM);
      text(game.code, 500, 490);// Labels
      fill(150);
      textSize(16);
      if (game.getQuestionType() == 1) {
        textAlign(LEFT, CENTER);
        text("Distance Sensor", 10, 100);
        textAlign(RIGHT, CENTER);
        text("Distance Sensor", 990, 100);
      }
      if (game.getQuestionType() == 2) {
        textAlign(LEFT, CENTER);
        text("Axis Sensor", 10, 200);
        textAlign(RIGHT, CENTER);
        text("Axis Sensor", 990, 200);
      }
      
      // Alternatives 
      fill(255);
      textSize(16);
      
      if (game.getQuestionType() == 1) {
        textAlign(LEFT, CENTER);
        text(game.distanceAnswer11, 50, 130);
        text(game.distanceAnswer12, 50, 160);
        textAlign(RIGHT, CENTER);
        text(game.distanceAnswer21, 950, 130);
        text(game.distanceAnswer22, 950, 160);
      }
      
      if (game.getQuestionType() == 2) {
        textAlign(LEFT, CENTER);
        text(game.axisAnswer11, 50, 240);
        text(game.axisAnswer12, 50, 270);
        textAlign(RIGHT, CENTER);
        text(game.axisAnswer21, 950, 240);
        text(game.axisAnswer22, 950, 270);
      }
      
      // Sensors
      
      if (game.getQuestionType() == 1) {
          
        textAlign(LEFT, CENTER);
        if (arduino.distance11) {
          fill(255, 0, 0);
        } else {
          fill(255);
        }
        ellipse(30, 132, 15, 15);
        if (arduino.distance12) {
          fill(255, 0, 0);
        } else {
          fill(255);
        }
        ellipse(30, 162, 15, 15);
        textAlign(RIGHT, CENTER);
        if (arduino.distance21) {
          fill(255, 0, 0);
        } else {
          fill(255);
        }
        ellipse(970, 132, 15, 15);
        if (arduino.distance22) {
          fill(255, 0, 0);
        } else {
          fill(255);
        }
        ellipse(970, 162, 15, 15);
      }
      
      if (game.getQuestionType() == 2) {
        
        textAlign(LEFT, CENTER);
        if (arduino.axis1 == 0) {
          fill(255, 0, 0);
        } else {
          fill(255);
        }
        ellipse(30, 242, 15, 15);
        if (arduino.axis1 == 1) {
          fill(255, 0, 0);
        } else {
          fill(255);
        }
        ellipse(30, 272, 15, 15);
        textAlign(RIGHT, CENTER);
        if (arduino.axis2 == 0) {
          fill(255, 0, 0);
        } else {
          fill(255);
        }
        ellipse(970, 242, 15, 15);
        if (arduino.axis2 == 1) {
          fill(255, 0, 0);
        } else {
          fill(255);
        }
        ellipse(970, 272, 15, 15);
      }
      
      drawBars();
    } else {
      
    }
  }
  
  
  void drawBars() {
    if (game.timeLeft < 0) {
      game.checkAnswer();
    }
    
    float currentDistance = map(game.timeLeft, game.timeToAnswer, 0, 400, 0);
    float currentColor = map(game.timeLeft, game.timeToAnswer, 0, 255, 0);
    fill(255, currentColor, currentColor);
    rect(500 - currentDistance, 400, 2*currentDistance, 30);
    
    game.timeLeft--;
  }
}
