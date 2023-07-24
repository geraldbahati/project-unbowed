class Config {
  static const String appName = 'ArtLife Project';
  static const String domain = '192.168.0.103:8000';

  static const String verifyOtpURL = '/api/user/verify-otp/';
  static const String sendNumberURL = '/api/user/send-otp/';
  static const String findUserURL = '/api/user';

  static const String apiMessages = '/api/chat/chatroom/';
  static const String apiChatRooms = '/api/chat/chatrooms/';

  static const String chatRoomWebSocketUrl = '/notifications/';
}
