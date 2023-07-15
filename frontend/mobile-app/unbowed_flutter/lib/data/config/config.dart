class Config {
  static const String appName = 'ArtLife Project';
  static const String domain = '127.0.0.1:8000';

  static const String loginURL = '/api/user/login';
  static const String logoutURL = '/api/user/logout';
  static const String registerURL = '/api/user/register';
  static const String findUserURL = '/api/user';

  static const String apiMessages = '/api/chat/chatroom/';
  static const String apiChatRooms = '/api/chat/chatrooms/';

  static const String chatRoomWebSocketUrl = 'ws://notifications/';
}
