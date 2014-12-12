class Game {
  
  JSONObject data;
  Arduino arduino;
  
  int timeToAnswer = 600;
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
  String axisAnswer11;
  String axisAnswer12;
  String axisAnswer21;
  String axisAnswer22;
  
  Game() {
    
  }
  
  boolean setCode(String code) {
    try {
      data = loadJSONObject("http://interfaces.meteor.com/api/game/" + code);
      return true;
    }
    catch (Exception e0) {  // Encoding Exception 
      println("Not found");
    } 
    return false;
  }
  
  void startGame() {
    timeLeft = timeToAnswer;
    currentQuestion = 0;
    renderQuestion();
  }
  
  void stopGame() {
    isRunning = false;
  }
  
  void checkAnswer() {
    timeLeft = timeToAnswer;
    println("checking answer");
    JSONObject question = data.getJSONArray("questions").getJSONObject(currentQuestion);
    
    int result = 0;
    if (question.getString("type").equals("distance")) {
      result = checkDistance();
    } else {
      result = checkAxis();
    }
    
    arduino.sendResult(result);
    uploadResult(question.getString("_id"), result);

    delay(1000);
    isRunning = false;
    
    if (data.getJSONArray("questions").size() > currentQuestion +1) {
      currentQuestion++;
      renderQuestion();
    }
  }
  
  void uploadResult(String questionId, int result) {
    loadJSONObject("http://interfaces.meteor.com/api/questions/" + questionId + "/set-result/" + result);
  }
  
  int getQuestionType() {
    JSONObject question = data.getJSONArray("questions").getJSONObject(currentQuestion);
    if (question.getString("type").equals("distance")) {
      return 1;
    }
    if (question.getString("type").equals("axis")) {
      return 2;
    }
    
    return 0;
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
      renderAxis();
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
  
  int checkAxis() {
    int result = 0;
    
    if (answerOrder == 0) {
      result += arduino.axis1 == 0 ? 1 : 0;
      result += arduino.axis2 == 0 ? 2 : 0;
    }
    if (answerOrder == 1) {
      result += arduino.axis1 == 1 ? 1 : 0;
      result += arduino.axis2 == 1 ? 2 : 0;
    }
    if (answerOrder == 2) {
      result += arduino.axis1 == 0 ? 1 : 0;
      result += arduino.axis2 == 1 ? 2 : 0;
    }
    if (answerOrder == 3) {
      result += arduino.axis1 == 1 ? 1 : 0;
      result += arduino.axis2 == 0 ? 2 : 0;
    }
    
    return result;
  }
  
  void renderAxis() {
    JSONObject question = data.getJSONArray("questions").getJSONObject(currentQuestion);
    JSONObject options = question.getJSONObject("axis"); 
    if (answerOrder == 0) {
      axisAnswer11 = options.getString("correctText");
      axisAnswer12 = options.getString("incorrectText");
      axisAnswer21 = options.getString("correctText");
      axisAnswer22 = options.getString("incorrectText");
    } 
    if (answerOrder == 1) {
      axisAnswer11 = options.getString("incorrectText");
      axisAnswer12 = options.getString("correctText");
      axisAnswer21 = options.getString("incorrectText");
      axisAnswer22 = options.getString("correctText");
    }
    if (answerOrder == 2) {
      axisAnswer11 = options.getString("correctText");
      axisAnswer12 = options.getString("incorrectText");
      axisAnswer21 = options.getString("incorrectText");
      axisAnswer22 = options.getString("correctText");
    }
    if (answerOrder == 3) {
      axisAnswer11 = options.getString("incorrectText");
      axisAnswer12 = options.getString("correctText");
      axisAnswer21 = options.getString("correctText");
      axisAnswer22 = options.getString("incorrectText");
    } 
  }
  
}
