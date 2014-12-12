class Arduino {
  
  boolean distance11;
  boolean distance12;
  boolean distance21;
  boolean distance22;
  int axis1 = 0;
  int axis2 = 1;
  boolean proximity1;
  boolean proximity2;
  Serial port;
  
  Arduino() {
    
  }
  
  void setMessage(String message) {

    try {
      String[] data = message.split(",");
      
      axis1 = parseInt(data[0]);
      axis2 = parseInt(data[1]);
      proximity1 = data[2].equals("1");
      proximity2 = data[3].equals("1");
      distance11 = data[4].equals("1");
      distance12 = data[5].equals("1");
      distance21 = data[6].equals("1");
      distance22 = data[7].equals("1");
      
    } catch (Exception e) {
      
    }
  }
  
  void sendResult(int result) {
    println("Sending to arduino: " + result);
    String message = result + "";
    port.write(message);
  }
  
}
