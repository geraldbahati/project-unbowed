import 'package:web_socket_channel/io.dart';

import '../exceptions/auth_exceptions.dart';
import '../models/chatroom/chatroom_model.dart';
import '../models/messages/message_model.dart';
import '../repositories/chat_repository.dart';
import '../services/api_services.dart';
import '../services/websocket_service.dart';

abstract class ChatProvider {
  Future<List<Message>> loadChats({
    required String chatRoomId,
  });

  Future<List<ChatroomModel>> laodChatrooms();

  Future<void> deleteChat({
    required String messageId,
  });
  Future<IOWebSocketChannel> connect({
    required String chatRoomId,
  });
}

class ChatService implements ChatProvider {
  late final IOWebSocketChannel _channel;
  @override
  Future<void> deleteChat({required String messageId}) {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  Future<IOWebSocketChannel> connect({required String chatRoomId}) async {
    _channel = await Websocket().connect(ChatRepository.connect(chatRoomId));
    return _channel;
  }

  @override
  Future<List<Message>> loadChats({required String chatRoomId}) async {
    var messages = ChatRepository.loadChats(chatRoomId);

    try {
      var response = await Api().load(messages);
      return response;
    } on Exception catch (_) {
      throw FailedToLoadChatsException();
    }
  }

  @override
  Future<List<ChatroomModel>> laodChatrooms() async {
    var chatRoomRepository = ChatRepository.loadChatrooms();

    try {
      var response = await Api().load(chatRoomRepository);
      return response;
    } on Exception catch (_) {
      throw FailedToLoadChatRoomsException();
    }
  }
}
