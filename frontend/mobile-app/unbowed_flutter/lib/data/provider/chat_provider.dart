import 'package:web_socket_channel/io.dart';

import '../models/messages/message_model.dart';
import '../repositories/chat_repository.dart';
import '../services/websocket_service.dart';

abstract class ChatProvider {
  Future<List<Message>> loadChats({
    required String chatRoomId,
  });

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
  Future<List<Message>> loadChats({required String chatRoomId}) {
    // TODO: implement loadChats
    throw UnimplementedError();
  }
}
