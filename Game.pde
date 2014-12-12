class Game {
  
  JSONObject data;
  Arduino arduino;
  
  int timeToAnswer = 500;
  int timeLeft;
  int currentQuestion;
  int answerOrder;
  boolean isRunning;
  String code;
  String questionText;
  String distanceAnswer11;
  String distanceAnswer12;
  String distanceAnswer21;
  String distanceAnswer22;
  
  Game(String code) {
    data = loadJSONObject("http://localhost:3000/api/game/" + code);
  }
  
  void startGame() {
    timeLeft = timeToAnswer;
    currentQuestion = 0;
    renderQuestion();
  }
  
  void checkAnswer() {
    timeLeft = timeToAnswer;
    println("checking answer");
    JSONObject question = data.getJSONArray("questions").getJSONObject(currentQuestion);
    
    int result = 0;
    if (question.getString("type").equals("distance")) {
      result = checkDistance();
    } else {
      
    }
    
    uploadResult(question.getString("_id"), result);
    
    delay(500);
    isRunning = false;
    
    if (data.getJSONArray("questions").size() > currentQuestion +1) {
      currentQuestion++;
      renderQuestion();
    }
  }
  
  void uploadResult(String questionId, int result) {
    loadJSONObject("http://localhost:3000/api/questions/" + questionId + "/set-result/" + result);
  }
  
  void renderQuestion() {
    isRunning = true;
    answerOrder = int(random(4));
    JSONObject question = data.getJSONArray("questions").getJSONObject(currentQuestion);
    code = data.getString("code");
    questionText = question.getString("question");
    if (question.getString("type").equals("distance")) {
      renderDistance();
    } else {
      distanceAnswer11 = "";
      distanceAnswer12 = "";
      distanceAnswer21 = "";
      distanceAnswer22 = "";
    }
  }
  
  int checkDistance() {
    int result = 0;
    if (answerOrder == 0) {
      result += arduino.distance11 && !arduino.distance12 ? 1 : 0;
      result += arduino.distance21 && !arduino.distance22 ? 2 : 0;
    }
    if (answerOrder == 1) {
      result += !arduino.distance11 && arduino.distance12 ? 1 : 0;
      result += !arduino.distance21 && arduino.distance22 ? 2 : 0;
    }
    if (answerOrder == 2) {
      result += arduino.distance11 && !arduino.distance12 ? 1 : 0;
      result += !arduino.distance21 && arduino.distance22 ? 2 : 0;
    }
    if (answerOrder == 3) {
      result += !arduino.distance11 && arduino.distance12 ? 1 : 0;
      result += arduino.distance21 && !arduino.distance22 ? 2 : 0;
    }
    
    return result;
  }
  
  void renderDistance() {
    JSONObject question = data.getJSONArray("questions").getJSONObject(currentQuestion);
    JSONObject options = question.getJSONObject("distance"); 
    if (answerOrder == 0) {
      distanceAnswer11 = options.getString("correctText");
      distanceAnswer12 = options.getString("incorrectText");
      distanceAnswer21 = options.getString("correctText");
      distanceAnswer22 = options.getString("incorrectText");
    } 
    if (answerOrder == 1) {
      distanceAnswer11 = options.getString("incorrectText");
      distanceAnswer12 = options.getString("correctText");
      distanceAnswer21 = options.getString("incorrectText");
      distanceAnswer22 = options.getString("correctText");
    }
    if (answerOrder == 2) {
      distanceAnswer11 = options.getString("correctText");
      distanceAnswer12 = options.getString("incorrectText");
      distanceAnswer21 = options.getString("incorrectText");
      distanceAnswer22 = options.getString("correctText");
    }
    if (answerOrder == 3) {
      distanceAnswer11 = options.getString("incorrectText");
      distanceAnswer12 = options.getString("correctText");
      distanceAnswer21 = options.getString("correctText");
      distanceAnswer22 = options.getString("incorrectText");
    }  
  }
  
}
