import 'package:unbowed_flutter/data/models/messages/message_model.dart';
import 'package:web_socket_channel/io.dart';

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
