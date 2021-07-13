class Utils{
  static String createUserId(String email){
    String userId = email.split('@')[0] + 
      email.split('@')[1].split('.')[0];
    return userId;
  }
}