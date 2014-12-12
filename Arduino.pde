class Arduino {
  
  boolean distance11;
  boolean distance12;
  boolean distance21;
  boolean distance22;
  
  Arduino() {
    
  }
  
  void setMessage(String message) {

    try {
      String[] data = message.split(",");
      
      distance11 = data[0].equals("1");
      distance12 = data[1].equals("1");
      distance21 = data[2].equals("1");
      distance22 = data[3].equals("1");
      
    } catch (Exception e) {
      
    }
    
  }
  
}
