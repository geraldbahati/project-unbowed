import 'package:unbowed_flutter/data/models/chatroom/chatroom_model.dart';
import 'package:unbowed_flutter/data/services/api_services.dart';
import 'package:web_socket_channel/io.dart';

import '../config/config.dart';
import '../models/messages/message_model.dart';
import '../services/websocket_service.dart';

class ChatRepository {
  static ApiService<List<Message>> loadChats(String chatRoomId) {
    var url = '${Config.apiMessages}$chatRoomId/';
    return ApiService(
      url: url,
      parse: (response) {
        return messageFromJson(response.body);
      },
    );
  }

  static ApiService<List<ChatroomModel>> loadChatrooms() {
    var url = Config.apiChatRooms;
    return ApiService(
      url: url,
      parse: (response) {
        return chatroomModelFromJson(response.body);
      },
    );
  }

  static WebsocketService<IOWebSocketChannel> connect(String url) {
    return WebsocketService(
      url: url,
      parse: (channel) => channel,
    );
  }
}
